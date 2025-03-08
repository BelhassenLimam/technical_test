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
            post(stories)
        }
    }

    func post(_ listStories: [Home.Story]) -> some View {
        ScrollView{
            ForEach(listStories, id: \.id) { story in
                let url = URL(string:story.url)!
                VStack(alignment: .leading, spacing: 15) {
                    AsyncImage(url: url,
                               placeholder: { Text("image_loading") })
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .fixedSize()
                    
                    HStack {
                        HStack(spacing: 3) {
                            Image(systemName: "heart")
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "text.bubble")
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "eye")
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "bookmark")
                        }
                    }
                    .font(.callout)
                    
                    Text(story.alt)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 55)
            }
        }
    }
}

