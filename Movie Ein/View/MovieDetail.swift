//
//  MovieDetail.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI
import AVKit
struct MovieDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDark") var isDark = false
    @State var movie: Movie
    @State var player = AVPlayer()
    @State var isTruncated: Bool = false
    @State var forceFullText: Bool = false
    @State var isTruncated1: Bool = false
    @State var forceFullText1: Bool = false
    @AppStorage("user") var user = ""
    @State private var isSuprise = false
    @State private var isLike = false
    @State private var isEvaluate = false
    @State private var isPoint = false
    @State private var point = 0
    @StateObject private var movieModel = MovieModel()
    @StateObject private var myContactModel = MyContactModel()
    
    var body: some View {
        var movieDetail = movieModel.getMovieByDocumentID(doc: movie.documentID!)
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    BackgroundPage()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            VideoPlayer(player: player)
                                .frame(height: geometry.size.height * 0.3)
                                .onAppear() {
                                    if player.currentItem == nil {
                                        if let mov = movie.TrailerUrl {
                                            let link = URL(string: mov) ?? URL(fileURLWithPath: "")
                                            let item = AVPlayerItem(url: link)
                                            player.replaceCurrentItem(with: item)
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                                        player.play()
                                    })
                                }
                            HStack {
                                Text("E")
                                    .font(.custom("Kalam-Bold", size: 24))
                                    .padding(.leading)
                                    .offset(y: -12)
                                Text("movie")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                                    .offset(x: -7, y: -15)
                                Spacer()
                            }
                            HStack {
                                if movieDetail.name != nil {
                                    Text(movieDetail.name!)
                                        .font(.largeTitle)
                                        .padding(.leading)
                                        .offset(y: -8)
                                        .bold()
                                }
                                Spacer()
                            }
                            HStack {
                                if movieDetail.published != nil {
                                    Text(movieDetail.published!, format: .dateTime.year())
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal)
                                }
                                if movieDetail.age != nil {
                                    Text("\(movieDetail.age!)+")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 5)
                                        .background(.secondary)
                                        .cornerRadius(3)
                                }
                                let rating = Float(movieModel.calculateRatingbyDocumentID(documentID: movie.documentID!))
                                let str = String(format: "Rating: %.1f/5", rating)
                                Text(str)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            HStack {
                                Text("Published by: ")
                                    .foregroundColor(.secondary)
                                    .padding(.leading)
                                if movieDetail.owner != nil {
                                    Text(movieDetail.owner!)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            VStack {
                                let textDes = movieDetail.description ?? ""
                                let text = Text("Description: \(textDes)")
                                Group {
                                    if forceFullText {
                                        text
                                            .fixedSize(horizontal: false, vertical: true)
                                    } else {
                                        TruncableText(
                                            text: text,
                                            lineLimit: 2
                                        ) {
                                            isTruncated = $0
                                        }
                                    }
                                }
                                .fontWeight(.medium)
                                .padding(.horizontal)
                                HStack {
                                    if isTruncated && !forceFullText {
                                        Button("show all") {
                                            forceFullText = true
                                        }
                                        .foregroundColor(Color("TheBlue"))
                                        .fontWeight(.medium)
                                        .padding(.horizontal)
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.top)
                            
                            HStack {
                                if movieDetail.director != nil {
                                    Text("Director: ")
                                    Text(movieDetail.director!)
                                }
                                Spacer()
                            }
                            .padding(.leading)
                            .padding(.top)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                            .font(.system(size: 13))
                            
                            VStack {
                                let str1 = movieDetail.actors ?? [String]()
                                let str = "Actors:  " + str1.joined(separator: ", ")
                                let text = Text(str)
                                if str != "" {
                                    HStack{
                                        Group {
                                            if forceFullText1 {
                                                text
                                                    .fixedSize(horizontal: false, vertical: true)
                                            } else {
                                                TruncableText(
                                                    text: text,
                                                    lineLimit: 1
                                                ) {
                                                    isTruncated1 = $0
                                                }
                                            }
                                        }
                                        .fontWeight(.light)
                                        .padding(.horizontal)
                                        .foregroundColor(.secondary)
                                        
                                        if isTruncated1 && !forceFullText1 {
                                            Button("show all") {
                                                forceFullText1 = true
                                            }
                                            .foregroundColor(Color("TheBlue"))
                                            .fontWeight(.light)
                                        }
                                        Spacer()
                                        
                                    }
                                    .font(.system(size: 13))
                                }
                            }
                            
                            Group {
                                categoryView
                                
                                HStack {
                                    Spacer()
                                    ZStack {
                                        let sup = self.myContactModel.checkIsContacted(userName: user, movieID: movie.documentID!, isContact: "isSuprise")
                                        Button {
                                            if !sup {
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isSuprise")
                                            } else {
                                                self.myContactModel.deleteContactStatus(userName: user, movieID: movie.documentID!, status: "isSuprise")
                                            }
                                        } label: {
                                            VStack {
                                                Image(systemName: !sup ? "plus" : "checkmark")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.06)
                                                    .foregroundColor(isDark ? .white : .gray)
                                                Text(sup ? "Suprised" : "Suprise")
                                                    .opacity(sup ? 0.6 : 1)
                                                    .font(.system(size: geometry.size.width * 0.035))
                                                    .foregroundColor(isDark ? .white : .gray)
                                            }
                                        }
                                        .opacity(user == "" ? 0.6 : 1)
                                        .disabled(user != "" ? false : true)
                                    }
                                    .frame(width: geometry.size.width * 0.3)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        let isUse = self.myContactModel.checkIsContacted(userName: user, movieID: movie.documentID!, isContact: "isRating")
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.3)){
                                                isEvaluate.toggle()
                                            }
                                        } label: {
                                            VStack {
                                                Image(systemName: isUse ? "star.fill" : "star")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.06)
                                                Text(!isUse ? "Evaluate" : "Evaluated")
                                                    .font(.system(size: geometry.size.width * 0.035))
                                            }
                                            .foregroundColor(isDark ? .white : .gray)
                                        }
                                        .disabled(isUse)
                                        .opacity(isUse ? 0.6 : 1)
                                        .opacity(user == "" ? 0.6 : 1)
                                        .disabled(user != "" ? false : true)
                                    }
                                    .frame(width: geometry.size.width * 0.3)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        let like = self.myContactModel.checkIsContacted(userName: user, movieID: movie.documentID!, isContact: "isLike")
                                        Button {
                                            if !like {
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isLike")
                                            } else {
                                                self.myContactModel.deleteContactStatus(userName: user, movieID: movie.documentID!, status: "isLike")
                                            }
                                        } label: {
                                            VStack {
                                                Image(systemName: like ? "hand.thumbsup.fill" : "hand.thumbsup")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width * 0.06)
                                                    .foregroundColor(isDark ? .white : .gray)
                                                Text(like ? "Liked" : "Like")
                                                    .opacity(isLike ? 0.6 : 1)
                                                    .font(.system(size: geometry.size.width * 0.035))
                                                    .foregroundColor(isDark ? .white : .gray)
                                            }
                                        }
                                        .opacity(user == "" ? 0.6 : 1)
                                        .disabled(user != "" ? false : true)
                                    }
                                    .frame(width: geometry.size.width * 0.3)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                relatedView
                            }
                        }
                    }
                }
                // Hide the system back button
                .navigationBarBackButtonHidden(true)
                // Add your custom back button here
                .navigationBarItems(leading:
                                        Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    player.pause()
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
                    HStack {
                        NavigationLink {
                            EditMovieView(movie: movie)
                        } label: {
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.title3)
                                .foregroundColor(isDark ? .white : .gray)
                                .opacity(user == movie.owner ? 1 : 0)
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            print("Tap")
                            player.pause()
                        })
                        .disabled(user == movie.owner ? false : true)
                    }
                })
                .toolbarBackground(isDark ? Color.black : Color("WhiteYellow3"), for: .navigationBar)
                .disabled(isEvaluate)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(movie.name!)
                            .font(.body.bold())
                            .accessibilityAddTraits(.isHeader)
                    }
                }
            }
            
            if isEvaluate {
                GeometryReader { geometry in
                    ZStack {
                        Color(isDark ? "Dark1" : "WhiteYellow")
                            .opacity(0.75)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                HStack {
                                    Button{
                                        print("1")
                                        point = 1
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            isPoint.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            // your code here
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                self.movieModel.addRatingByMovieImagelink(url: movie.ImageUrl!, rating: 1)
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isRating")
                                                isEvaluate.toggle()
                                            }
                                        }
                                    } label: {
                                        Image(systemName: isPoint && point >= 1 ? "star.fill" : "star")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.06)
                                    }
                                    Button {
                                        print("2")
                                        point = 2
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            isPoint.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            // your code here
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                self.movieModel.addRatingByMovieImagelink(url: movie.ImageUrl!, rating: 2)
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isRating")
                                                isEvaluate.toggle()
                                            }
                                        }
                                    } label: {
                                        Image(systemName: isPoint && point >= 2 ? "star.fill" : "star")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.06)
                                    }
                                    Button{
                                        print("3")
                                        point = 3
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            isPoint.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            // your code here
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                self.movieModel.addRatingByMovieImagelink(url: movie.ImageUrl!, rating: 3)
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isRating")
                                                isEvaluate.toggle()
                                            }
                                        }
                                    } label: {
                                        Image(systemName: isPoint && point >= 3 ? "star.fill" : "star")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.06)
                                    }
                                    Button{
                                        print("4")
                                        point = 4
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            isPoint.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            // your code here
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                self.movieModel.addRatingByMovieImagelink(url: movie.ImageUrl!, rating: 4)
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isRating")
                                                isEvaluate.toggle()
                                            }
                                        }
                                    } label: {
                                        Image(systemName: isPoint && point >= 4 ? "star.fill" : "star")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.06)
                                    }
                                    Button{
                                        point = 5
                                        print("5")
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            isPoint.toggle()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            // your code here
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                self.movieModel.addRatingByMovieImagelink(url: movie.ImageUrl!, rating: 5)
                                                self.myContactModel.addContactStatus(userName: user, movieID: movie.documentID!, status: "isRating")
                                                isEvaluate.toggle()
                                            }
                                        }
                                    } label: {
                                        Image(systemName: isPoint && point == 5 ? "star.fill" : "star")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.06)
                                    }
                                }
                                .foregroundColor(isDark ? .white : .gray)
                                .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45 / 3)
                                .padding()
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)){
                                    isEvaluate.toggle()
                                }
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.06)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 25)
                            .padding(.top, 40)
                        }
                        Spacer()
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
    
    var categoryView: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(movie.category!, id: \.self) { cate in
                    Text(cate)
                        .padding(5)
                        .background(isDark ? .black : Color("WhiteYellow3"))
                        .cornerRadius(20)
                        .shadow(radius: 2)
                        .padding(5)
                }
            }
            .padding(.leading)
        }
    }
    
    var relatedView: some View {
        VStack {
            if movie.category!.count > 0 {
                let categoryMo = movieModel.getPriogityCategory(movie: movie)
                
                let movies = movieModel.getCategoryMovie(category: categoryMo)
                
                if movies.count > 0 {
                    HStack {
                        Text("Related")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                        //.foregroundColor(!isDark && isColor != "WhiteYellow" ? Color.black : Color.white)
                            .padding()
                            .padding(.top, 20)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(movies) { movie in
                                if movie.name != self.movie.name {
                                    VStack {
                                        NavigationLink {
                                            MovieDetail(movie: movie)
                                        } label: {
                                            MyMovieStack(movie: movie, imgWidth: 85, imgHeigh: 125, status: true)
                                            //MyMovieRow(movie: movie, imgSize: 100)
                                        }
                                        .simultaneousGesture(TapGesture().onEnded{
                                            print("Tap")
                                            player.pause()
                                        })
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movie())
    }
}
