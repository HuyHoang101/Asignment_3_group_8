//
//  MyMovie.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 16/09/2023.
//

import SwiftUI
import FirebaseStorage

struct MyMovie: View {
    @State private var isUser = false
    @AppStorage("user") var user = ""
    @AppStorage("isDark") var isDark = false
    @State private var btn = false
    @State private var btnLogin = false
    @AppStorage("statusLogin") var statusLogin = false
    @State private var status = false
    @StateObject private var movieModel = MovieModel()
    @StateObject private var accountModel = AccountModel()
    @StateObject private var contactModel = MyContactModel()
    @State private var img = UIImage()
    @Binding var status1: Bool
    @State private var myContact = "isLike"
    
    
    var body: some View {
        let account = self.accountModel.accounts.filter({$0.userName == user })
        let myMovieID = contactModel.contacts.filter({ $0.userName == user })
        
        NavigationStack {
            GeometryReader {geometry in
                Group {
                    if status {
                        
                            ZStack {
                                let movies = movieModel.movies.filter( { $0.owner == user } )
                                BackgroundPage()
                                ScrollView (.vertical, showsIndicators: false){
                                    VStack {
                                        if account.count > 0 {
                                            AccountAnimation(account: account[0], imgSize: geometry.size.width * 0.4)
                                        }
                                        
                                        HStack {
                                            Text("My Movie")
                                                .font(.system(size: 32, weight: .heavy, design: .rounded))
                                            //.foregroundColor(!isDark && isColor != "WhiteYellow" ? Color.black : Color.white)
                                                .padding()
                                                .padding(.top, 20)
                                            Spacer()
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(movies) { movie in
                                                    VStack {
                                                        NavigationLink {
                                                            MovieDetail(movie: movie)
                                                        } label: {
                                                            MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.35, imgHeigh: geometry.size.height * 0.28, status: true)
                                                            //MyMovieRow(movie: movie, imgSize: 100)
                                                        }
                                                        .simultaneousGesture(TapGesture().onEnded{
                                                            print("Tap")
                                                            status1 = true
                                                        })
                                                        Spacer()
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                        HStack {
                                            Text("Activities History")
                                                .font(.system(size: 32, weight: .heavy, design: .rounded))
                                            //.foregroundColor(!isDark && isColor != "WhiteYellow" ? Color.black : Color.white)
                                                .padding(.top, 60)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        
                                            HStack {
                                                FilterContact(isWidth: geometry.size.width * 0.52, isContact: $myContact)
                                                    .padding(.horizontal)
                                                    .foregroundColor(isDark ? .white : .black)
                                                Spacer()
                                            }
                                        
                                        
                                        if myMovieID.count > 0 {
                                            let myMovieLike = movieModel.getMoviesByDocumentIDArray(documentID: myMovieID[0].isLike!)
                                            let myMovieSup = movieModel.getMoviesByDocumentIDArray(documentID: myMovieID[0].isSuprise!)
                                            let myMovieRate = movieModel.getMoviesByDocumentIDArray(documentID: myMovieID[0].isRating!)
                                            if myContact == "isLike" {
                                                if myMovieLike.count > 0 {
                                                    HStack {
                                                        Text("Movie liked")
                                                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                                                        //.foregroundColor(!isDark && isColor != "WhiteYellow" ? Color.black : Color.white)
                                                            .padding()
                                                        Spacer()
                                                    }
                                                    ScrollView(.horizontal, showsIndicators: false) {
                                                        HStack {
                                                            ForEach(myMovieLike) { movie in
                                                                VStack {
                                                                    NavigationLink {
                                                                        MovieDetail(movie: movie)
                                                                    } label: {
                                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.35, imgHeigh: geometry.size.height * 0.28, status: true)
                                                                        //MyMovieRow(movie: movie, imgSize: 100)
                                                                    }
                                                                    .simultaneousGesture(TapGesture().onEnded{
                                                                        print("Tap")
                                                                        status1 = true
                                                                    })
                                                                    Spacer()
                                                                }
                                                            }
                                                        }
                                                        .padding(.horizontal)
                                                    }
                                                }
                                            } else if myContact == "isSuprise" {
                                                if myMovieSup.count > 0 {
                                                    HStack {
                                                        Text("Movie suprised")
                                                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                                                        //.foregroundColor(!isDark && isColor != "WhiteYellow" ? Color.black : Color.white)
                                                            .padding()
                                                        Spacer()
                                                    }
                                                    ScrollView(.horizontal, showsIndicators: false) {
                                                        HStack {
                                                            ForEach(myMovieSup) { movie in
                                                                VStack {
                                                                    NavigationLink {
                                                                        MovieDetail(movie: movie)
                                                                    } label: {
                                                                        MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.35, imgHeigh: geometry.size.height * 0.28, status: true)
                                                                        //MyMovieRow(movie: movie, imgSize: 100)
                                                                    }
                                                                    .simultaneousGesture(TapGesture().onEnded{
                                                                        print("Tap")
                                                                        status1 = true
                                                                    })
                                                                    Spacer()
                                                                }
                                                            }
                                                        }
                                                        .padding(.horizontal)
                                                    }
                                                }
                                            } else if myContact == "isRate" {
                                                if myMovieRate.count > 0 {
                                                    HStack {
                                                        Text("Movie rated")
                                                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                                                        //.foregroundColor(!isDark && isColor != "WhiteYellow" ? Color.black : Color.white)
                                                            .padding()
                                                        Spacer()
                                                    }
                                                    ScrollView(.horizontal, showsIndicators: false) {
                                                        HStack {
                                                                ForEach(myMovieRate) { movie in
                                                                    VStack {
                                                                        NavigationLink {
                                                                            MovieDetail(movie: movie)
                                                                        } label: {
                                                                            MyMovieStack(movie: movie, imgWidth: geometry.size.width * 0.35, imgHeigh: geometry.size.height * 0.28, status: true)
                                                                            //MyMovieRow(movie: movie, imgSize: 100)
                                                                        }
                                                                        .simultaneousGesture(TapGesture().onEnded{
                                                                            print("Tap")
                                                                            status1 = true
                                                                        })
                                                                        Spacer()
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
                                
                            }
                            .navigationBarItems(trailing:
                                                    Button(action: {
                                    isUser.toggle()
                            }) {
                                NavigationLink {
                                    AddMoviePage(isUse: $isUser)
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(!isDark ? Color.black : Color.white)
                                }
                                .simultaneousGesture(TapGesture().onEnded{
                                    print("Tap")
                                    status1 = true
                                })
                            })
                            .onAppear() {
                                status1 = false
                            }
                    } else {
                        ZStack {
                            ZStack {
                                BackgroundPage()
                                VStack {
                                    
                                    Spacer()
                                    
                                    Text("Login for enjoy more service")
                                        .foregroundColor(!isDark ? .black : .white)
                                        .font(.system(size: 57, weight: .heavy, design: .rounded))
                                        .padding()
                                    
                                    Spacer()
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.7)) {
                                            btn.toggle()
                                        }
                                    } label: {
                                        Text("Go to login here! →")
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .shadow(radius: 6)
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }
                            .disabled(btn)
                            .blur(radius: btn ? 10 : 0)
                            
                            if btn {
                                ZStack {
                                    content
                                        .opacity(btnLogin ? 0.5 : 1)
                                        .blur(radius: btnLogin ? 3 : 0)
                                        .disabled(btnLogin)
                                    if btnLogin {
                                        LoadingAnimation(status: statusLogin)
                                    }
                                }
                                .onChange(of: btnLogin) { _ in
                                    if btnLogin {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                            // your code here
                                            btnLogin.toggle()
                                            if statusLogin {
                                                btn.toggle()
                                            }
                                        }
                                    }
                                }
                                .transition(.move(edge: .bottom))
                            }
                        }
                    }
                }
                .onAppear {
                    status = user != "" ? true : false
                }
                .onChange(of: btn) { _ in
                    status = user != "" ? true : false
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
            }
        }
        .onAppear {
            status1 = false
        }
    }
    
    var content: some View {
        ZStack {
            Login_RegisterView(btn: $btnLogin)
                .transition(.move(edge: .bottom))
            VStack{
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.7)){
                            btn.toggle()
                        }
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                    }
                    .foregroundColor(!isDark ? .gray : .white)
                    .padding(.top, 20)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
        }
    }
    
    func retrievedImage(url : String?) {
        let storageRef = Storage.storage().reference()
        if url != nil {
            let fileRef = storageRef.child(url!)
            
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                
                if error == nil && data != nil {
                    
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.img = image
                        }
                    }
                }
            }
        }
    }
}

struct MyMovie_Previews: PreviewProvider {
    static var previews: some View {
        MyMovie(status1: .constant(false))
    }
}
