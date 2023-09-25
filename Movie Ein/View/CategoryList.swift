//
//  CategoryList.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI

struct CategoryList: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDark") var isDark = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundPage()
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        NavigationLink {
                            ListMovieView(title: "Action")
                        }label: {
                            Text("Action")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Fiction")
                        }label: {
                            Text("Fiction")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Romance")
                        }label: {
                            Text("Romance")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Fantasy")
                        }label: {
                            Text("Fantasy")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Adventure")
                        }label: {
                            Text("Adventure")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Anime/Family")
                        }label: {
                            Text("Anime/Family")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Thiller")
                        }label: {
                            Text("Thiller")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Comedy")
                        }label: {
                            Text("Comedy")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Horror")
                        }label: {
                            Text("Horror")
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink {
                            ListMovieView(title: "Drama")
                        }label: {
                            Text("Drama")
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                    .foregroundColor(isDark ? .white : .black)
                }
            }
            .navigationTitle("Category")
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

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
