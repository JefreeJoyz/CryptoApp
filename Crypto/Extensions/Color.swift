//
//  Color.swift
//  Crypto
//
//  Created by Eugene Yakushev on 16.06.2022.
//

import Foundation
import SwiftUI

// Каждый раз, когда будем юзать Color, будем иметь доступ к theme, а theme - будет иметь доступ к ColorTheme
extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}
