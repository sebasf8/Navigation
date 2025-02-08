//
//  NavigateViewModifier.swift
//  Navigation
//
//  Created by Sebastian Fernandez on 8/2/25.
//

import SwiftUI

struct NavigateViewModifier<Destination>: ViewModifier where Destination: Routable {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @State private var isActive: Bool = false
    @Binding private var route: Destination?

    init(route: Binding<Destination?>) {
        self._route = route
    }

    func body(content: Content) -> some View {
        VStack(spacing: .zero) {
            NavigationLink(isActive: $isActive) {
                route?.makeView()
            } label: {
                EmptyView()
            }

            content
                .onChange(of: isActive) { newValue in
                    if !isActive {
                        route = nil
                    }
                }
                .onChange(of: route) { newValue in
                    if let newValue {
                        coordinator.pushView(newValue)
                        isActive = true
                    }
                }
                .onChange(of: coordinator.showRoot) { newValue in
                    if newValue {
                        isActive = false
                    }
                }
        }
    }
}

extension View {
    public func navigate<Destination>(to route: Binding<Destination?>) -> some View where Destination: Routable {
        self.modifier(NavigateViewModifier(route: route))
    }
}
