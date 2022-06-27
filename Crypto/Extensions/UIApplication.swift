//
//  UIApplication.swift
//  Crypto
//
//  Created by Eugene Yakushev on 27.06.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    // прячет клавиатуру
    func endEditing () {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
