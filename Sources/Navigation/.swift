//
//  ContentView.swift
//  NavigationApp
//
//  Created by Sebastian Fernandez on 8/2/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = NavigationCoordinator()
    @State private var route: Route?

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("Hello, world!")

                Button {
                    route = .secondScreen
                } label: {
                    Text("Navigate to next view")
                }
            }
            .navigate(to: $route)
            .padding()
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}

struct SecondScreen: View {
    @State private var route: Route?

    var body: some View {
        VStack {
            Button {
                route = .thirdScreen
            } label: {
                Text("To third Screen")
            }
        }
        .navigate(to: $route)
    }
}

struct ThirdScreen: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator

    var body: some View {
        VStack {
            VStack {
                Button("Pop to root") {
                    coordinator.popToRoot()
                }
                Text("Third Screen")
            }
        }
    }
}

enum Route: Routable {
    case secondScreen
    case thirdScreen

    func makeView() -> some View {
        switch self {
        case .secondScreen:
            SecondScreen()
        case .thirdScreen:
            ThirdScreen()
        }
    }
}
