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
    
    // Меняем цвет текста в навигейшн баре 
    init () {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]

    }
    
    /*
     Since ios 16 there is a dedicated modifier for setting any toolbar background color (including the navigation bar):

     .toolbarBackground(.red, in: .navigationBar)
     
     https://stackoverflow.com/questions/69196530/swiftui-changing-navigation-bar-background-color-for-inline-navigationbartitledi
     */
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm) // Все "дети" NavigationView теперь имеют доступ к HomeViewModel
        }
    }
}
