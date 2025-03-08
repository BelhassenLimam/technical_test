//
//  Home.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

enum Home {
    enum Action {
        case didAppear
    }

    enum State {
        case loading
        case loaded(stories: Stories)
        case error(Error)

        struct Error {
            var title: String?
            var message: String?
        }
    }
}

extension Home {
    struct Story: Equatable {
        let id: Int
        let url: String
        let photographer: String
        let photographerURL: String
        let alt: String
    }
}
