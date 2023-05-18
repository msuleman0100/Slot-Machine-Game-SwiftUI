//
//  CenterView.swift
//  Slot Machine
//
//  Created by Content Arcade on 18/05/2023.
//

import Foundation
import SwiftUI


struct CenterVertically: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}
struct CenterHorizontally: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
