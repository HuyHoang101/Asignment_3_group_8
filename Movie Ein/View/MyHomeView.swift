//
//  MyHomeView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI

struct MyHomeView: View {
    @StateObject private var movieModel = MovieModel()
    @State private var count = 0
    @State private var status = 0
    @AppStorage("isDark") var isDark = false
    @AppStorage("user") var user = ""
    @Binding var isUsing: Bool
    @State private var isCategoryList = ""
    @State private var searching = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let movies = movieModel.get5Movie()
        if !searching {
            NavigationStack {
                GeometryReader { geometry in
                    ZStack{
                        BackgroundPage()
                        ScrollView {
                            VStack {
                                HStack {
                                    if user == "" {
                                        NavigationLink{
                                            ListMovieView(title: "Action")
                                        } label: {
                                            Text("Action")
                                                .padding(5)
                                                .background(isDark ? .black : Color("WhiteYellow3"))
                                                .foregroundColor(!isDark ? .black : .white)
                                                .cornerRadius(20)
                                                .shadow(radius: 2)
                                                .padding(5)
                                        }
                                        .simultaneousGesture(TapGesture().onEnded{
                                            print("Tap")
                                            isUsing = true
                                        })
                                        
                                        NavigationLink{
                                            ListMovieView(title: "Adventure")
                                        } label: {
                                            Text("Adventure")
                                                .padding(5)
                                                .background(isDark ? .black : Color("WhiteYellow3"))
                                                .foregroundColor(!isDark ? .black : .white)
                                                .cornerRadius(20)
                                                .shadow(radius: 2)
                                                .padding(5)
                                        }
                                        .simultaneousGesture(TapGesture().onEnded{
                                            print("Tap")
                                            isUsing = true
                                        })
                                    } else {
                                        NavigationLink{
                                            MymovieList()
                                        } label: {
                                            Text("My Movie")
                                                .padding(5)
                                                .background(isDark ? .black : Color("WhiteYellow3"))
                                                .foregroundColor(!isDark ? .black : .white)
                                                .cornerRadius(20)
                                                .shadow(radius: 2)
                                                .padding(5)
                                        }
                                        .simultaneousGesture(TapGesture().onEnded{
                                            print("Tap")
                                            isUsing = true
                                        })
                                    }
                                    
                                    NavigationLink {
                                        CategoryList()
                                    }label: {
                                        HStack {
                                            Text("Category")
                                            Image(systemName: "arrow.down")
                                        }
                                        .padding(5)
                                        .background(isDark ? .black : Color("WhiteYellow3"))
                                        .foregroundColor(!isDark ? .black : .white)
                                        .cornerRadius(20)
                                        .shadow(radius: 2)
                                        .padding(5)
                                    }
                                    .simultaneousGesture(TapGesture().onEnded{
                                        print("Tap")
                                        isUsing = true
                                    })
                                    
                                    Spacer()
                                }
                                .padding()
                                
                                VStack {
                                    if movies.count == 5{
                                        if status == 0 {
                                            NavigationLink {
                                                MovieDetail(movie: movies[0])
                                            } label: {
                                                ZStack {
                                                    MyMovieStack(movie: movies[0], imgWidth: geometry.size.width * 0.9, imgHeigh: geometry.size.width * 0.9 * 1.45, status: false)
                                                    VStack {
                                                        let str = movies[0].category!.joined(separator: " ★ ")
                                                        HStack {
                                                            Text("E")
                                                                .font(.custom("Kalam-Bold", size: 46))
                                                            Text("movie")
                                                                .font(.system(size: 20))
                                                                .offset(x: -4, y: -8.5)
                                                            
                                                            Spacer()
                                                        }
                                                        .shadow(radius: 1)
                                                        .padding(.horizontal, 22)
                                                        .foregroundColor(.white)
                                                        
                                                        Spacer()
                                                        ZStack {
                                                            Text(str)
                                                                .foregroundColor(.white)
                                                                .font(.title2)
                                                                .padding()
                                                                .background(Color("Dark"))
                                                                .opacity(0.6)
                                                                .cornerRadius(5)
                                                            Text(str)
                                                                .padding()
                                                                .font(.title2)
                                                                .frame(width: geometry.size.width * 0.9)
                                                                .padding(.vertical, 50)
                                                                .foregroundColor(.white)
                                                                .shadow(radius: 1)
                                                        }
                                                    }
                                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * 1.45)
                                                }
                                                
                                            }
                                        }else if status == 1 {
                                            NavigationLink {
                                                MovieDetail(movie: movies[1])
                                            } label: {
                                                ZStack {
                                                    MyMovieStack(movie: movies[1], imgWidth: geometry.size.width * 0.9, imgHeigh: geometry.size.width * 0.9 * 1.45, status: false)
                                                    VStack {
                                                        let str = movies[1].category!.joined(separator: " ★ ")
                                                        HStack {
                                                            Text("E")
                                                                .font(.custom("Kalam-Bold", size: 46))
                                                            Text("movie")
                                                                .font(.system(size: 20))
                                                                .offset(x: -4, y: -8.5)
                                                            
                                                            Spacer()
                                                        }
                                                        .shadow(radius: 1)
                                                        .padding(.horizontal, 22)
                                                        .foregroundColor(.white)
                                                        
                                                        Spacer()
                                                        ZStack {
                                                            Text(str)
                                                                .foregroundColor(.white)
                                                                .font(.title2)
                                                                .padding()
                                                                .background(Color("Dark"))
                                                                .opacity(0.6)
                                                                .cornerRadius(5)
                                                            Text(str)
                                                                .padding()
                                                                .font(.title2)
                                                                .frame(width: geometry.size.width * 0.9)
                                                                .padding(.vertical, 50)
                                                                .foregroundColor(.white)
                                                                .shadow(radius: 1)
                                                        }
                                                    }
                                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * 1.45)
                                                }
                                                
                                            }
                                        }else if status == 2 {
                                            NavigationLink {
                                                MovieDetail(movie: movies[2])
                                            } label: {
                                                ZStack {
                                                    MyMovieStack(movie: movies[2], imgWidth: geometry.size.width * 0.9, imgHeigh: geometry.size.width * 0.9 * 1.45, status: false)
                                                    VStack {
                                                        let str = movies[2].category!.joined(separator: " ★ ")
                                                        HStack {
                                                            Text("E")
                                                                .font(.custom("Kalam-Bold", size: 46))
                                                            Text("movie")
                                                                .font(.system(size: 20))
                                                                .offset(x: -4, y: -8.5)
                                                            
                                                            Spacer()
                                                        }
                                                        .shadow(radius: 1)
                                                        .padding(.horizontal, 22)
                                                        .foregroundColor(.white)
                                                        
                                                        Spacer()
                                                        ZStack {
                                                            Text(str)
                                                                .foregroundColor(.white)
                                                                .font(.title2)
                                                                .padding()
                                                                .background(Color("Dark"))
                                                                .opacity(0.6)
                                                                .cornerRadius(5)
                                                            Text(str)
                                                                .padding()
                                                                .font(.title2)
                                                                .frame(width: geometry.size.width * 0.9)
                                                                .padding(.vertical, 50)
                                                                .foregroundColor(.white)
                                                                .shadow(radius: 1)
                                                        }
                                                    }
                                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * 1.45)
                                                }
                                                
                                            }
                                        }else if status == 3 {
                                            NavigationLink {
                                                MovieDetail(movie: movies[3])
                                            } label: {
                                                ZStack {
                                                    MyMovieStack(movie: movies[3], imgWidth: geometry.size.width * 0.9, imgHeigh: geometry.size.width * 0.9 * 1.45, status: false)
                                                    VStack {
                                                        let str = movies[3].category!.joined(separator: " ★ ")
                                                        HStack {
                                                            Text("E")
                                                                .font(.custom("Kalam-Bold", size: 46))
                                                            Text("movie")
                                                                .font(.system(size: 20))
                                                                .offset(x: -4, y: -8.5)
                                                            
                                                            Spacer()
                                                        }
                                                        .shadow(radius: 1)
                                                        .padding(.horizontal, 22)
                                                        .foregroundColor(.white)
                                                        
                                                        Spacer()
                                                        
                                                        ZStack {
                                                            Text(str)
                                                                .foregroundColor(.white)
                                                                .font(.title2)
                                                                .padding()
                                                                .background(Color("Dark"))
                                                                .opacity(0.6)
                                                                .cornerRadius(5)
                                                            Text(str)
                                                                .padding()
                                                                .font(.title2)
                                                                .frame(width: geometry.size.width * 0.9)
                                                                .padding(.vertical, 50)
                                                                .foregroundColor(.white)
                                                                .shadow(radius: 1)
                                                        }
                                                    }
                                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * 1.45)
                                                }
                                                
                                            }
                                        }else {
                                            NavigationLink {
                                                MovieDetail(movie: movies[4])
                                            } label: {
                                                ZStack {
                                                    MyMovieStack(movie: movies[4], imgWidth: geometry.size.width * 0.9, imgHeigh: geometry.size.width * 0.9 * 1.45, status: false)
                                                    
                                                    VStack {
                                                        let str = movies[4].category!.joined(separator: " ★ ")
                                                        HStack {
                                                            Text("E")
                                                                .font(.custom("Kalam-Bold", size: 46))
                                                            Text("movie")
                                                                .font(.system(size: 20))
                                                                .offset(x: -4, y: -8.5)
                                                            
                                                            Spacer()
                                                        }
                                                        .shadow(radius: 1)
                                                        .padding(.horizontal, 22)
                                                        .foregroundColor(.white)
                                                        
                                                        Spacer()
                                                        
                                                        ZStack {
                                                            Text(str)
                                                                .foregroundColor(.white)
                                                                .font(.title2)
                                                                .padding()
                                                                .background(Color("Dark"))
                                                                .opacity(0.6)
                                                                .cornerRadius(5)
                                                            Text(str)
                                                                .padding()
                                                                .font(.title2)
                                                                .frame(width: geometry.size.width * 0.9)
                                                                .padding(.vertical, 50)
                                                                .foregroundColor(.white)
                                                                .shadow(radius: 1)
                                                        }
                                                    }
                                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * 1.45)
                                                }
                                            }
                                        }
                                    }
                                }
                                .simultaneousGesture(TapGesture().onEnded{
                                    print("Tap")
                                    isUsing = true
                                })
                                .onReceive(timer) { _ in
                                    count += 1
                                    if count > 5 {
                                        count = 0
                                        withAnimation(.easeInOut(duration: 0.15)){
                                            status = (status + 1) % 5
                                        }
                                    }
                                }
                                let movieActions = movieModel.getCategoryMovie(category: "Action")
                                if movieActions.count > 0 {
                                    VStack {
                                        HStack {
                                            Text("Action")
                                                .padding(.horizontal)
                                                .font(.largeTitle)
                                                .offset(y: 14)
                                            Spacer()
                                        }
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movieActions) {movie in
                                                    NavigationLink {
                                                        MovieDetail(movie: movie)
                                                    } label: {
                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.28, imgHeigh: geometry.size.width * 0.28 * 1.45, status: false)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        print("Tap")
                                                        isUsing = true
                                                    })
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                
                                let movieComedy = movieModel.getCategoryMovie(category: "Comedy")
                                if movieComedy.count > 0 {
                                    VStack {
                                        HStack {
                                            Text("Comedy")
                                                .padding(.horizontal)
                                                .font(.largeTitle)
                                                .offset(y: 14)
                                            Spacer()
                                        }
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movieComedy) {movie in
                                                    NavigationLink {
                                                        MovieDetail(movie: movie)
                                                    } label: {
                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.28, imgHeigh: geometry.size.width * 0.28 * 1.45, status: false)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        print("Tap")
                                                        isUsing = true
                                                    })
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                
                                let movieAdventure = movieModel.getCategoryMovie(category: "Adventure")
                                if movieAdventure.count > 0 {
                                    VStack {
                                        HStack {
                                            Text("Adventure")
                                                .padding(.horizontal)
                                                .font(.largeTitle)
                                                .offset(y: 14)
                                            Spacer()
                                        }
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movieAdventure) {movie in
                                                    NavigationLink {
                                                        MovieDetail(movie: movie)
                                                    } label: {
                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.28, imgHeigh: geometry.size.width * 0.28 * 1.45, status: false)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        print("Tap")
                                                        isUsing = true
                                                    })
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                
                                let movieHorror = movieModel.getCategoryMovie(category: "Horror")
                                if movieHorror.count > 0 {
                                    VStack {
                                        HStack {
                                            Text("Horror")
                                                .padding(.horizontal)
                                                .font(.largeTitle)
                                                .offset(y: 14)
                                            Spacer()
                                        }
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movieHorror) {movie in
                                                    NavigationLink {
                                                        MovieDetail(movie: movie)
                                                    } label: {
                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.28, imgHeigh: geometry.size.width * 0.28 * 1.45, status: false)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        print("Tap")
                                                        isUsing = true
                                                    })
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                
                                let movieFantasy = movieModel.getCategoryMovie(category: "Fantasy")
                                if movieFantasy.count > 0 {
                                    VStack {
                                        HStack {
                                            Text("Fantasy")
                                                .padding(.horizontal)
                                                .font(.largeTitle)
                                                .offset(y: 14)
                                            Spacer()
                                        }
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movieFantasy) {movie in
                                                    NavigationLink {
                                                        MovieDetail(movie: movie)
                                                    } label: {
                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.28, imgHeigh: geometry.size.width * 0.28 * 1.45, status: false)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        print("Tap")
                                                        isUsing = true
                                                    })
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                                
                                let movieAnimation_Family = movieModel.getCategoryMovie(category: "Anime/Family")
                                if movieAnimation_Family.count > 0 {
                                    VStack {
                                        HStack {
                                            Text("Anime/Family")
                                                .padding(.horizontal)
                                                .font(.largeTitle)
                                                .offset(y: 14)
                                            Spacer()
                                        }
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movieAnimation_Family) {movie in
                                                    NavigationLink {
                                                        MovieDetail(movie: movie)
                                                    } label: {
                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.28, imgHeigh: geometry.size.width * 0.28 * 1.45, status: false)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        print("Tap")
                                                        isUsing = true
                                                    })
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical)
                                }
                            }
                        }
                    }
                    // Add your custom back button here
                    .navigationBarItems(leading:
                                            Button(action: {
                        isDark.toggle()
                    }) {
                        HStack {
                            Image(systemName: isDark ? "moon.fill" : "sun.max.fill")
                                .font(.title3)
                                .foregroundColor(isDark ? .white : .gray)
                        }
                    })
                    .navigationBarItems(trailing:
                                            Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            searching = true
                        }
                        isUsing = true
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.title3)
                                .foregroundColor(isDark ? .white : .gray)
                        }
                    })
                    .toolbarBackground(isDark ? Color.black : Color("WhiteYellow3"), for: .navigationBar)
                }
                .onAppear() {
                    isUsing = false
                }
            }
        } else {
            SearchView(isExit: $searching)
                .transition(.move(edge: .trailing))
        }
    }
    
}

struct MyHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyHomeView(isUsing: .constant(false))
    }
}
