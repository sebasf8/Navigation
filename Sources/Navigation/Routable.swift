//
//  Routable.swift
//  Navigation
//
//  Created by Sebastian Fernandez on 8/2/25.
//

import Foundation
import SwiftUI

public protocol Routable: Equatable {
    associatedtype Destination: View

    @MainActor @ViewBuilder func makeView() -> Destination
}
