//
//  Interacting.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation

public protocol Interacting<Action> {
    associatedtype Action

    func handleAction(_ action: Action)
}
