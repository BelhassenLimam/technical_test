//
//  viewStore.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import SwiftUI
import Combine

@dynamicMemberLookup
/// Wrapper class containing Interactor and Presenter
/// Defining single dependency for each SwiftUI view
final public class ViewStore<Interactor, Presenter>: ObservableObject where Presenter: ObservableObject {
    private let _interactor: Interactor
    private var _presenter: Presenter

    // swiftlint:disable:next discouraged_cancellable_bags
    private var cancellableBag = Set<AnyCancellable>()

    var presenterObservation: AnyCancellable?

    public init(interactor: Interactor, presenter: Presenter) where Interactor: Interacting, Presenter: Presenting {
        self._interactor = interactor
        self._presenter = presenter
        self.presenterObservation = presenter.objectWillChange.sink(receiveValue: { [weak self] _ in
            self?.objectWillChange.send()
        })
    }
}

extension ViewStore where Presenter: Presenting {

    /// Returns the current state of the presenter. Usefull when `Presenter.State` is an enum.
    ///
    /// This is a function so that we can be sure that changes are not possible from outside,
    /// even in the `$store.state` form.
    public func state() -> Presenter.State {
        self._presenter.state
    }

    /// Returns the resulting value of a given key path.
    public subscript<Value>(dynamicMember keyPath: KeyPath<Presenter.State, Value>) -> Value {
        self._presenter.state[keyPath: keyPath]
    }

    public convenience init(initialState: Presenter.State, interactor: Interactor) where Interactor: Interacting {
        self.init(interactor: interactor, presenter: .init(state: initialState))
    }
}

extension ViewStore where Interactor: Interacting {
    public func handleAction(_ action: Interactor.Action) {
        _interactor.handleAction(action)
    }
}

extension ViewStore where Interactor: Interacting, Presenter: Presenting {
    public struct BindingSetter<Value> {
        public let transaction: Transaction
        public let oldValue: Value
        public let newValue: Value
    }

    public func binding<Value>(
        keyPath: WritableKeyPath<Presenter.State, Value>,
        send valueToAction: @escaping (BindingSetter<Value>) -> Interactor.Action
    ) -> Binding<Value> {
        .init(
            get: { self._presenter.state[keyPath: keyPath] },
            set: { (value, transaction) in
                let setter = BindingSetter(
                    transaction: transaction,
                    oldValue: self._presenter.state[keyPath: keyPath],
                    newValue: value
                )
                self.handleAction(valueToAction(setter))
            }
        )
    }

    public func binding<Value>(
        keyPath: WritableKeyPath<Presenter.State, Value>,
        send action: Interactor.Action
    ) -> Binding<Value> {
        binding(
            keyPath: keyPath,
            send: { _ in
                action
            }
        )
    }

    public func bindingWithDebounce<Value>(
        _ delay: RunLoop.SchedulerTimeType.Stride,
        keyPath: WritableKeyPath<Presenter.State, Value>,
        send valueToAction: @escaping (BindingSetter<Value>) -> Interactor.Action
    ) -> Binding<Value> where Value: Equatable {
        let debouncer = PassthroughSubject<BindingSetter<Value>, Never>()
        debouncer
            .debounce(for: delay, scheduler: RunLoop.main)
            .removeDuplicates { $0.newValue == $1.newValue }
            .sink { [weak self] bindingSetter in
                guard let self else { return }

                self.handleAction(valueToAction(bindingSetter))
            }
            .store(in: &cancellableBag)

        return Binding(
            get: { self._presenter.state[keyPath: keyPath] },
            set: { (value, transaction) in
                debouncer.send(
                    BindingSetter(
                        transaction: transaction,
                        oldValue: self._presenter.state[keyPath: keyPath],
                        newValue: value
                    )
                )
            }
        )
    }
}
