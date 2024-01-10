import SwiftUI
import Foundation

struct ContentView: View {
    @State var scrollOffset = CGFloat.zero
    @State var buttonOpacity = 1.0
    @State private var isFunctionSelectionPresented = false

    init() {
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Future Of Furnish")
                    .fontWeight(.heavy)
                    .font(.system(size: min(scrollOffset / 10 + 10, 70))) // Limit font size to 60
                    .foregroundColor(.black)
                    .offset(y: min(scrollOffset / -60*9 , 187))
                Text("We are proud to present our MURTH AI. MURTH will be your designer and help you identify furniture from the design. Our aim is to provide the most convenient solution for interior design.")
                    .fontWeight(.light)
                    .font(.system(size: 15)) // Limit font size to 60
                    .foregroundColor(.black)
                    .offset(y: min(scrollOffset / -60*9 , 187))
                    .opacity(min(scrollOffset / 500,1))
                Button(action: {
                    isFunctionSelectionPresented = true // Update state to show Murth view
                }) {
                    Text("Challenge Murth! >")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(5)
                        .opacity(min(scrollOffset / 500,187))
                        .offset(y: min(scrollOffset / -60*9 , 187))
                }
            }
            .frame(minHeight: 400)
            ObservableScrollView(scrollOffset: $scrollOffset) { proxy in
                LazyVStack(alignment: .leading) {
                    ForEach(1..<85) { index in
                        Text(".")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .sheet(isPresented: $isFunctionSelectionPresented) {
            Murth()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  static var defaultValue = CGFloat.zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}

// A ScrollView wrapper that tracks scroll offset changes.
struct ObservableScrollView<Content>: View where Content : View {
  @Namespace var scrollSpace

  @Binding var scrollOffset: CGFloat
  let content: (ScrollViewProxy) -> Content

  init(scrollOffset: Binding<CGFloat>,
       @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
    _scrollOffset = scrollOffset
    self.content = content
  }

  var body: some View {
    ScrollView {
      ScrollViewReader { proxy in
        content(proxy)
          .background(GeometryReader { geo in
              let offset = -geo.frame(in: .named(scrollSpace)).minY
              Color.clear
                .preference(key: ScrollViewOffsetPreferenceKey.self,
                            value: offset)
          })
      }
    }
    .coordinateSpace(name: scrollSpace)
    .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
      scrollOffset = value
    }
  }
}
