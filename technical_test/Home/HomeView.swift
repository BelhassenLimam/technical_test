//
//  HomeView.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import SwiftUI
import CoreData

struct HomeView<Interactor: HomeInteracting>: View{
    typealias Store = ViewStore<Interactor, HomePresenter>
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var store: Store
    
    init(store: @escaping () -> Store) {
        _store = StateObject(wrappedValue: store())
    }

    var body: some View {
        switch store.state() {
        case .loading:
            ScrollView(showsIndicators: false) {
                Text("En cours de chargement")
            }.onAppear { store.handleAction(.didAppear) }
        case .error(let error):
            Text("erreur")
        case .loaded(let stories):
            Text("Données reçu")
        }
    }
}

