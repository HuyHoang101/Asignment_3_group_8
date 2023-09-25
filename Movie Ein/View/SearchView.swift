//
//  SearchView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var movieModel = MovieModel()
    @State private var movies = [Movie]()
    @State private var searchText = ""
    @Binding var isExit: Bool
    @AppStorage("isDark") var isDark = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    BackgroundPage()
                        .opacity(0.75)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(movies) { movie in
                                NavigationLink {
                                    MovieDetail(movie: movie)
                                } label: {
                                    MyMovieRow(movie: movie, imgSize: geo.size.height * 0.12)
                                        .frame(height: geo.size.height * 0.12 * 1.5)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Search")
                .navigationBarItems(leading:
                                        Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)){
                        isExit.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(isDark ? .white : .gray)
                    }
                })
                .toolbarBackground(isDark ? Color.black : Color("WhiteYellow3"), for: .navigationBar)
            }
        }
        .searchable(text: $searchText, prompt: "Movie Name")
        .onChange(of: searchText) { newValue in
            if !newValue.isEmpty {
                movies = movieModel.movies.filter { $0.name!.lowercased().contains(newValue.lowercased()) }
            } else {
                movies = [Movie]()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isExit: .constant(false))
    }
}
