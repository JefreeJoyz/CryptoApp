//
//  CryptoApp.swift
//  Crypto
//
//  Created by Eugene Yakushev on 16.06.2022.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var vm = HomeViewModel ()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm) // Все "дети" NavigationView теперь имеют доступ к HomeViewModel
        }
    }
}
