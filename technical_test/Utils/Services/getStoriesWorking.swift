//
//  getStoriesWorking.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation
import Combine

protocol getStoriesWorking {
    /**
    Requests the list of photos

    - returns: parsed Story returned from data source, or throws error via AnyPublisher
    */
    func getAllStories() -> AnyPublisher<Stories, Error>
}
