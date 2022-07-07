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
    @State private var showLaunchView: Bool = true
    
    // Меняем цвет текста в навигейшн баре 
    init () {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear // красим бекграунд, который под листом. Его видно, если двигать лист вверх/вниз
    }
    
    /*
     Since ios 16 there is a dedicated modifier for setting any toolbar background color (including the navigation bar):

     .toolbarBackground(.red, in: .navigationBar)
     
     https://stackoverflow.com/questions/69196530/swiftui-changing-navigation-bar-background-color-for-inline-navigationbartitledi
     */
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm) // Все "дети" NavigationView теперь имеют доступ к HomeViewModel
                .navigationViewStyle(.stack)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
