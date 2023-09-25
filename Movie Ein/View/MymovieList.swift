//
//  MymovieList.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 20/09/2023.
//

import SwiftUI

struct MymovieList: View {
    @AppStorage("user") var user = ""
    @StateObject private var movieModel = MovieModel()
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDark") var isDark = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    BackgroundPage()
                        List {
                            ForEach(movieModel.movies) { movie in
                                if movie.owner == user {
                                    HStack {
                                        NavigationLink {
                                            MovieDetail(movie: movie)
                                        } label: {
                                            MyMovieRow(movie: movie, imgSize: geo.size.width * 0.25)
                                                .frame(height: geo.size.width * 0.25 * 1.5)
                                        }
                                        .padding(.vertical)
                                    }
                                }
                            }
                            .onDelete(perform: removeMovie)
                            .listRowBackground(Color(isDark ? "Dark" : "WhiteYellow"))
                        }
                        .scrollContentBackground(.hidden)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Movie")
                        .font(.title2.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationBarBackButtonHidden(true)
            // Add your custom back button here
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(isDark ? .white : .gray)
                }
            })
            .navigationBarItems(trailing:
                                    Button(action: {
            }) {
                NavigationLink {
                    AddMoviePage(isUse: .constant(true))
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(isDark ? .white : .gray)
                    }
                }
            })
            .toolbarBackground(isDark ? Color.black : Color("WhiteYellow3"), for: .navigationBar)
        }
        
    }
    
    func removeMovie(at offsets: IndexSet) {
        for index in offsets {
            if let documentID = movieModel.movies[index].documentID {
                movieModel.deleteMovie(documentID: documentID)
            }
        }
    }
}

struct MymovieList_Previews: PreviewProvider {
    static var previews: some View {
        MymovieList()
    }
}
