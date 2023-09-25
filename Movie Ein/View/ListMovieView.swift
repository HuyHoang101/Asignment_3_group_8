//
//  ListMovieView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI

struct ListMovieView: View {
    @State var title: String
    @StateObject var movieModel = MovieModel()
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDark") var isDark = false
    
    var body: some View {
        let movieList = movieModel.getCategoryMovie(category: title)
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    BackgroundPage()
                    ScrollView (.vertical, showsIndicators: false){
                        VStack {
                            ForEach(movieList) { list in
                                HStack {
                                    NavigationLink {
                                        MovieDetail(movie: list)
                                    } label: {
                                        MyMovieRow(movie: list, imgSize: geo.size.width * 0.25)
                                            .frame(height: geo.size.width * 0.25 * 1.5)
                                    }
                                    .padding(.vertical)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            // Hide the system back button
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
            .toolbarBackground(isDark ? Color.black : Color("WhiteYellow3"), for: .navigationBar)
        }
    }
}

struct ListMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ListMovieView(title: "")
    }
}
