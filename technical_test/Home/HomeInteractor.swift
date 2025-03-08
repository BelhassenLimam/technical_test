//
//  HomeInteractor.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation
import Combine

// MARK: - HomeInteracting
protocol HomeInteracting: Interacting<Home.Action> {
    func handleAction(_ action: Home.Action)
}

final class HomeInteractor: ObservableObject, getStoriesWorking {
    func getAllStories() -> AnyPublisher<Stories, any Error> {
        let apiClient = URLSessionAPIClient<ApiRouting>()
        
        return apiClient.request(.getAllStories)
    }
    
    private var cancellables = Set<AnyCancellable>()
    @Published var listStories: [Home.Story]?
    private let presenter: HomePresenting

    init(
        presenter: HomePresenting
    ) {
        self.presenter = presenter
    }
}

// MARK: - HandleActions
extension HomeInteractor: HomeInteracting {
    func handleAction(_ action: Home.Action) {
        switch action {
        case .didAppear:
            didAppear()
        }
    }
}

private extension HomeInteractor {
    func didAppear() {
        presenter.presentLoading()
        fetchStories()
    }
    
    private func stateStoriesList(listStories: [Story]) -> [Home.Story] {
        let stateStoriesList: [Home.Story] = listStories.map { story in
            
            return Home.Story(
                id: story.id ?? 0,
                url: story.src?.medium ?? "",
                photographer: story.photographer ?? "",
                photographerURL: story.photographerURL ?? "",
                alt: story.alt ?? ""
            )
        }
        
        return stateStoriesList
    }
    
    func fetchStories() {
        getAllStories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { data in
                
            }, receiveValue: {[weak self] response in
                guard let list = response.photos else { return }
                self?.listStories = self?.stateStoriesList(listStories: list)
                self?.presenter.present(storiesData: self?.listStories ?? [])
                
            }).store(in: &cancellables)
    }
    
    
}

