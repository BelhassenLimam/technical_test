//
//  technical_testApp.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import SwiftUI

@main
struct technical_testApp: App {
    let persistenceController = PersistenceController.shared
    let view = HomeView {
        let presenter = HomePresenter(state: .loading)
        let interactor = HomeInteractor(
            presenter: presenter
        )

        return .init(interactor: interactor, presenter: presenter)
    }
    var body: some Scene {
        
        WindowGroup {
            view
        }
    }
}
