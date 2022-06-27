//
//  SearchBarView.swift
//  Crypto
//
//  Created by Eugene Yakushev on 27.06.2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchtext: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchtext.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchtext)
                .disableAutocorrection(true)
                .foregroundColor(Color.theme.accent)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.theme.accent)
                    .opacity(searchtext.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchtext = ""
                    }
                
                
                ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.5),
                            radius: 10,
                            x: 0,
                            y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchtext: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            SearchBarView(searchtext: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
