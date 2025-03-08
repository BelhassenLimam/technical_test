//
//  Presenting.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation

public protocol Presenting<State> {
    associatedtype State

    var state: State { get set }

    init(state: State)
}
