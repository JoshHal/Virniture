//
//  ContentView.swift
//  Glosstest
//
//  Created by Josh Halbert on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scrollPosition: CGFloat = 0.0
    @State private var scrollableHeight: CGFloat = 500
    
    var body: some View {
        ScrollView {
            VStack {
                Text("REIMAGINE")
                    .font(.system(size: scrollPosition))
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .alignmentGuide(.top) { _ in
                        -scrollPosition
                    }
            }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollPositionKey.self, value: geometry.frame(in: .global).minY)
                        .preference(key: ScrollableHeightKey.self, value: geometry.size.height)
                }
            )
        }
        .onPreferenceChange(ScrollPositionKey.self) { value in
            scrollPosition = value
            // Use scrollPosition as desired
            print("Scroll position: \(scrollPosition)")
        }
        .onPreferenceChange(ScrollableHeightKey.self) { value in
            scrollableHeight = value
            // Use scrollableHeight as desired
            print("Scrollable height: \(scrollableHeight)")
        }
    }
}

struct ScrollPositionKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollableHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
