//
//  CircleButtonAnimationView.swift
//  Crypto
//
//  Created by Eugene Yakushev on 16.06.2022.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
            Circle()
                .stroke(lineWidth: 5.0)
                .scale(animate ? 1.0 : 0.0)
                .opacity(animate ? 0.0 : 1.0)
                .animation(.easeInOut(duration: 1.0), value: animate)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
    }
}
