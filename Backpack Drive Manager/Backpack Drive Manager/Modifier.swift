//
//  Modifier.swift
//  Backpack Drive Manager
//
//  Created by Eulices Martinez on 11/8/23.
//

import SwiftUI

struct TextEntry: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(2)
            .border(Color.black)
            .background(Color.white)
    }
}

struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            //.padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
    }
}
struct submitDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .cornerRadius(10)
    }
}

