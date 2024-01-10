import Foundation
import SwiftUI

struct Murth: View {
    @State private var selectedRoomType: String = "Bedroom"
    @State private var isFunctionSelectionPresented = false
    @State var scrollOffset = CGFloat.zero
    @State var buttonOpacity = 1.0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Future Of Furnish")
                    .fontWeight(.heavy)
                    .font(.system(size: min(scrollOffset / 10 + 10, 70))) // Limit font size to 60
                    .foregroundColor(.black)
                    .offset(y: min(scrollOffset / -60*9 , 187))
                Text("All in one platform for interior design by AI")
                    .fontWeight(.light)
                    .font(.system(size: 23)) // Limit font size to 60
                    .foregroundColor(.black)
                    .offset(y: min(scrollOffset / -60*9 , 187))
                    .opacity(min(scrollOffset / 500,1))
                Text("<<< Challenge MURTH? Swipe left!")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(5)
                    .opacity(min(scrollOffset / 500,187))
                    .offset(y: min(scrollOffset / -60*9 , 187))
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
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 { // Detect swipe left
                            selectedRoomType = "Bedroom"
                            isFunctionSelectionPresented = true
                        }
                    }
            )
            .sheet(isPresented: $isFunctionSelectionPresented) {
                RoomTypeView()
            }
        }
    }
}

struct RoomTypeView: View {
    @State private var selectedRoomType: String = ""
    @State private var isFunctionSelectionPresented = false
    
    
    
    let roomTypes = [
        "Living Room",
        "Bedroom",
        "Bathroom",
        "Dining Room",
        "Lawn",
        "Garden",
        "Balcony",
        "Attic",
        "Kitchen",
        "Study",
        "Home Office",
        "Game Room",
        // Add more room types here
    ]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    Text("Room Type:")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ForEach(roomTypes, id: \.self) { roomType in
                        Button(action: {
                            selectedRoomType = roomType
                            isFunctionSelectionPresented = true
                        }) {
                            HStack {
                                Image(systemName: selectedRoomType == roomType ? "circle.fill" : "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(selectedRoomType == roomType ? .accentColor : .black)
                                    .fontWeight(.thin)
                                
                                Text(roomType)
                                    .font(.system(size: 25))
                                    .fontWeight(.thin)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                            .padding(.leading,20)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
            .sheet(isPresented: $isFunctionSelectionPresented) {
                FunctionSelectionView(selectedRoomType: selectedRoomType)
            }
        }
    }
}

struct FunctionSelectionView: View {
    let selectedRoomType: String
    @State private var selectedFunctions: [String] = []
    @State private var isStyleSelectionPresented = false
    
    var functions: [String] {
        switch selectedRoomType {
        case "Living Room":
            return [
                "Sofa",
                "TV",
                "Coffee Table",
                "Rugs",
                "Lamp",
                "Bookshelf",
                "Media Console"
            ]
        case "Bedroom":
            return [
                "Sofa",
                "TV",
                "Twin Bed",
                "King Size Bed",
                "Lamp",
                "Dresser",
                "Wardrobe"
            ]
        case "Bathroom":
            return [
                "His and Her Basin",
                "Single Basin",
                "Bath Tub",
                "Shower",
                "Towel Rack",
                "Toilet",
                "Hanging Light",
                "Makeup Light",
                "Storage Cabinet"
            ]
        case "Dining Room":
            return [
                "Seamless Dining Table",
                "Fabric Chair",
                "Wooden Chair",
                "Tempered Glass Table",
                "Big Rugs",
                "Table Lamp",
                "Chandelier",
                "Island",
                "China Cabinet"
            ]
        case "Lawn":
            return [
                "Lawn Chairs",
                "Picnic Table",
                "Sun Umbrella",
                "Grill",
                "Fire Pit",
                "Outdoor Lighting",
                "Swing Set",
                "Hammock"
            ]
        case "Garden":
            return [
                "Garden Bench",
                "Planters",
                "Water Fountain",
                "Garden Statues",
                "Gazebo",
                "Greenhouse",
                "Potting Bench"
            ]
        case "Balcony":
            return [
                "Balcony Chairs",
                "Small Table",
                "Hanging Plants",
                "Outdoor Rug",
                "Bistro Set",
                "Folding Lounge Chairs"
            ]
        case "Attic":
            return [
                "Storage Boxes",
                "Unused Furniture",
                "Workstation",
                "Lounger",
                "Attic Fan",
                "Air Purifier"
            ]
        case "Kitchen":
            return [
                "Kitchen Island",
                "Bar Stools",
                "Refrigerator",
                "Oven",
                "Microwave",
                "Pantry",
                "Dishwasher"
            ]
        case "Study":
            return [
                "Study Desk",
                "Desk Chair",
                "Bookshelves",
                "Reading Lamp",
                "Filing Cabinet",
                "Wall Clock"
            ]
        case "Home Office":
            return [
                "Office Desk",
                "Ergonomic Chair",
                "Computer Monitor",
                "Printer",
                "Shredder",
                "Bulletin Board",
                "Whiteboard"
            ]
        case "Game Room":
            return [
                "Pool Table",
                "Foosball Table",
                "Video Game Console",
                "Gaming PC",
                "Bean Bags",
                "Gaming Chair"
            ]
        // Add more cases and their respective furniture here

        default:
            return []
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                Text("Pick functions for your \(selectedRoomType)!")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top, 10)
                ForEach(functions, id: \.self) { function in
                    Button(action: {
                        if selectedFunctions.contains(function) {
                            selectedFunctions.removeAll(where: { $0 == function })
                        } else {
                            selectedFunctions.append(function)
                        }
                    }) {
                        HStack {
                            Image(systemName: selectedFunctions.contains(function) ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(selectedFunctions.contains(function) ? .accentColor : .primary)
                                .fontWeight(.thin)
                            
                            Text(function)
                                .font(.system(size: 25))
                                .fontWeight(.thin)
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .padding(.leading,20)
                    }
                }
                
                Button(action: {
                    isStyleSelectionPresented = true
                }) {
                    Text("Next")
                        .font(.system(size: 25))
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
        .navigationTitle("Function Selection")
        .sheet(isPresented: $isStyleSelectionPresented) {
            let selectedFunctionsText = selectedFunctions.joined(separator: ", ")
            StyleSelectionView(selectedRoomType: selectedRoomType, selectedFunction: selectedFunctionsText)
        }
    }
}


struct StyleSelectionView: View {
    let selectedRoomType: String
    let selectedFunction: String
    @State private var selectedStyle: String = ""
    @State private var isNextPagePresented = false
    
    let styles = [
        "Modern",
        "Minimal",
        "Brutalist",
        "Futuristic",
        "Scandinavian",
        "le corbusier",
        "wabi-sabi",
        "industrial",
        "bauhaus",
        "Classic",
        "Vernacular",
        "Art deco",
        "Maximal",
        "Natural",
    ]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                Text("Pick a style for your \(selectedRoomType)!")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                ForEach(styles, id: \.self) { style in
                    Button(action: {
                        selectedStyle = style
                        isNextPagePresented = true
                    }) {
                        HStack {
                            Image(systemName: selectedStyle == style ? "circle.fill" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(selectedStyle == style ? .accentColor : .primary)
                                .fontWeight(.thin)
                            
                            Text(style)
                                .font(.system(size: 25))
                                .fontWeight(.thin)
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .padding(.leading,20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
        .navigationTitle("Style Selection")
        .sheet(isPresented: $isNextPagePresented) {
            ToneSelectionView(selectedRoomType: selectedRoomType, selectedFunction: selectedFunction, selectedStyle: selectedStyle)
        }
    }
}

struct ToneSelectionView: View {
    let selectedRoomType: String
    let selectedFunction: String
    let selectedStyle: String
    @State private var selectedTone: String = ""
    @State private var isNextPagePresented = false
    
    let styles = [
        "Warm",
        "Cozy",
        "Clean",
        "Relaxed",
        "Calm",
        "Comfortable",
        "Chilly",
        "Mediterranean",
        "Naturalistic",
        "Earthy",
        "Upbeat",
        "Exciting",
        "fun"
    ]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                Text("Any Vibes?")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                ForEach(styles, id: \.self) { style in
                    Button(action: {
                        selectedTone = style
                        isNextPagePresented = true
                    }) {
                        HStack {
                            Image(systemName: selectedTone == style ? "circle.fill" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(selectedTone == style ? .accentColor : .primary)
                                .fontWeight(.thin)
                            
                            Text(style)
                                .font(.system(size: 25))
                                .fontWeight(.thin)
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .padding(.leading,20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
        .navigationTitle("Tone Selection")
        .sheet(isPresented: $isNextPagePresented) {
            LightingSelectionView(selectedRoomType: selectedRoomType, selectedFunction: selectedFunction, selectedStyle: selectedStyle, selectedTone: selectedTone)
        }
    }
}

struct LightingSelectionView: View {
    let selectedRoomType: String
    let selectedFunction: String
    let selectedStyle: String
    let selectedTone: String
    @State private var selectedLight: String = ""
    @State private var isNextPagePresented = false
    
    let styles = [
        "Natural",
        "Warm",
        "fluorescent",
        "blue tint",
        "green tint",
        "red tint",
        "lantern-lit",
        "Sunlight",
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("how about lighting?")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.bottom, 20)
            
            ForEach(styles, id: \.self) { style in
                Button(action: {
                    selectedLight = style
                    isNextPagePresented = true
                }) {
                    HStack {
                        Image(systemName: selectedLight == style ? "circle.fill" : "circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(selectedLight == style ? .accentColor : .primary)
                            .fontWeight(.thin)
                        
                        Text(style)
                            .font(.system(size: 25))
                            .fontWeight(.thin)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .padding(.leading,20)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
        .navigationTitle("light style selection")
        .sheet(isPresented: $isNextPagePresented) {
            NextPageView(selectedRoomType: selectedRoomType, selectedFunction: selectedFunction, selectedStyle: selectedStyle, selectedTone: selectedTone, selectedLighting:selectedLight)
        }
    }
}

struct NextPageView: View {
    let selectedRoomType: String
    let selectedFunction: String
    let selectedStyle: String
    let selectedTone: String
    let selectedLighting: String
    
    // The API endpoint URL
    let apiURL = "https://fun.rawin1.repl.co/virniture/(prompt)%22"
    
    @State private var imageURLs: [URL] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("This might be what you're looking for !")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<imageURLs.count, id: \.self) { index in
                            AsyncImage(url: imageURLs[index]) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 10)
                                    .cornerRadius(40)
                            } placeholder: {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
            .onAppear {
                makeRequest()
            }
        }
    }
    
    private func makeRequest() {
        let prompt = "https://fun.rawin1.repl.co/virniture/\(selectedStyle) \(selectedRoomType) with \(selectedFunction), \(selectedTone) tone, \(selectedLighting) lighting,hyperrealistic,photorealistic"
        let formattedPrompt = prompt.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: formattedPrompt) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data,
               let imageURLString = String(data: data, encoding: .utf8) {
                let newImageURLs = imageURLString
                    .components(separatedBy: ",")
                    .compactMap { urlString in
                        // Convert each URL string to URL object
                        URL(string: urlString.trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                
                DispatchQueue.main.async {
                    imageURLs = newImageURLs
                }
            }
        }.resume()
    }
}
