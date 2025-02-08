//
//  NavigationCoordinator.swift
//  Navigation
//
//  Created by Sebastian Fernandez on 8/2/25.
//

import Foundation

@MainActor
public final class NavigationCoordinator: ObservableObject {
    private(set) var showRoot: Bool = true

    public init() {}
    
    public func popToRoot() {
        showRoot = true
        objectWillChange.send()
    }

    func pushView(_ destination: any Routable) {
        showRoot = false
    }
}
