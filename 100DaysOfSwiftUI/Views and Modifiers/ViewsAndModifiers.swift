//
//  ViewsAndModifiers.swift
//  100DaysOfSwiftUI
//
//  Created by Bhanuteja on 31/05/20.
//  Copyright © 2020 annam. All rights reserved.
//

import SwiftUI

struct ViewsAndModifiers: View {
    @State private var useRedText = false

    var body: some View {
//        Text("Hello World")
//        .titleStyle()

//        Color.blue
//        .frame(width: 300, height: 200)
//        .watermarked(with: "Hacking with Swift")
        
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}
