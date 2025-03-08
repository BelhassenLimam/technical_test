//
//  HomePresenter.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation

protocol HomePresenting {
    func presentLoading()
    func present(storiesData: [Home.Story])
    func presentError(error: Home.State.Error)
}

final class HomePresenter: Presenting, ObservableObject {
    @Published var state: Home.State

    init(state: Home.State) {
        self.state = state
    }
}

extension HomePresenter: HomePresenting {
    func present(storiesData: [Home.Story]) {
        state = .loaded(stories: storiesData)
    }

    func presentLoading() {
        state = .loading
    }

    func presentError(error: Home.State.Error) {
        state = .error(error)
    }
}
