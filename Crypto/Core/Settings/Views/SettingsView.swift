//
//  SettingsView.swift
//  Crypto
//
//  Created by Eugene Yakushev on 06.07.2022.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")! // Плохая практика, но в данном случае мы уверены, что здесь всегда есть урл
    let linkedInURL = URL(string: "https://www.linkedin.com/in/yevhen-yakushev/")!
    let gitHubURL = URL(string: "https://github.com/JefreeJoyz")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationView {
            List {
                basicInfo
                coinGeckoSection
                developerSection
            }
            .tint(.blue)
            .font(.headline)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    //XmarkButton()  по хорошему, здесь должна быть только эта строчка. Мы создали отдельный компонент, который хотим переиспользовать и на других экранах. Но в xcode Version 13.4.1 (13F100) вьюха отображается, но не отрабатывает закрытие sheet.
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var basicInfo: some View {
        Section {
            VStack (alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following Nick Sarno. It uses MVVM, Combine and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("My LinkedIn ☕️", destination: linkedInURL)
            Link("My GitHub 💼", destination: gitHubURL)
        } header: {
            Text("Basic info")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack (alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data was gotten from free API CoinGecko")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coinGeckoURL)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack (alignment: .leading) {
                Text("This app was done through the Nick Sarno youtube course. I enjoied by every minute of building this app :)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
        } header: {
            Text("Developer")
        }
    }
}
