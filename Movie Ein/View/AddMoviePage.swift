//
//  AddMoviePage.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 15/09/2023.
//

import SwiftUI
import AVKit
import FirebaseFirestore
import FirebaseStorage

struct AddMoviePage: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDark") var isDark = false
    @State var image1: UIImage?
    @State var shouldShowImagePicker1 = false
    @State var shouldShowImagePicker2 = false
    @State var shouldShowVideoPicker = false
    @State var status = false
    @State var status1 = false
    @State var status2 = false
    @State var status3 = false
    @State var dis = true
    @StateObject var videoPicker = VideoPicker()
    @State var url = [Video]()
    @State var name = ""
    @State var age = 1
    @State var description = ""
    @State var published = Date.now
    @State var category = [String]()
    @State var director = ""
    @State var actors = [String]()
    @State var actor = ""
    @State var categoryBtn = false
    @State var actorBtn = false
    @StateObject private var movieModel = MovieModel()
    @AppStorage("user") var user = ""
    
    @Binding var isUse: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let color2 = isDark ? "Dark1" : "WhiteYellow2"
        var count = 0
        GeometryReader { geometry in
            ZStack {
                BackgroundPage()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Group {
                            Button {
                                shouldShowImagePicker1.toggle()
                            } label: {
                                if let image = self.image1 {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.27)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 3)
                                        }
                                        .cornerRadius(20)
                                        .foregroundColor(!isDark ? .black : .white)
                                        .shadow(radius: 2)
                                        .padding()
                                } else {
                                    Text("Poster")
                                        .font(.title)
                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.27)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 15).stroke(style: StrokeStyle(lineWidth: 3, dash: [11]))
                                        }
                                        .foregroundColor(!isDark ? .blue : .white)
                                        .padding()
                                }
                            }
                            .fullScreenCover(isPresented: $shouldShowImagePicker1, onDismiss: nil){
                                ImagePicker(image: $image1)
                            }
                            
                            
                            HStack {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.5)){
                                        status.toggle()
                                    }
                                } label: {
                                    Image(systemName: "folder.fill.badge.plus")
                                        .font(.title)
                                        .foregroundColor(!isDark ? .blue : .white)
                                        .padding(.vertical)
                                        .padding(.leading)
                                    
                                    Text("Trailer.mp4")
                                        .foregroundColor(!isDark ? .blue : .white)
                                }
                                
                                if status1 {
                                    Image(systemName: "checkmark.circle")
                                        .font(.title)
                                        .foregroundColor(!isDark ? .green : .white)
                                }
                                
                                Spacer()
                            }
                            .disabled(status1)
                            .opacity(status1 ? 0.6 : 1)
                        }
                        HStack {
                            Text("Title: ")
                            TextField("movie name", text: $name)
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        
                        HStack {
                            Text("Director: ")
                            TextField("director", text: $director)
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        
                        HStack {
                            Text("Description: ")
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top)
                        TextEditor(text: $description)
                            .foregroundStyle(!isDark ? .black : .white)
                            .padding(.horizontal)
                            .frame(height: geometry.size.height * 0.3)
                            .shadow(radius: 1)
                            .padding(.bottom)
                        
                        HStack {
                            Text("Age: \(age)+")
        
                            Spacer ()
                            
                            Picker("Favorite Color", selection: $age, content: {
                                ForEach(1...30, id: \.self) { num in
                                    Text("\(num)").tag(num)
                                }
                            })
                            .pickerStyle(.wheel)
                            .labelsHidden()
                            .frame(width: geometry.size.width * 0.4)
                            .frame(idealHeight: geometry.size.width * 0.23)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        
                        HStack {
                            DatePicker(selection: $published, in: ...Date.now, displayedComponents: .date) {
                                Text("Released Date: ")
                            }
                            .frame(width: geometry.size.width * 0.75)
                            
                            Spacer()
                        }
                        .padding()
                        
                        HStack {
                            Text("Category: ")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(category, id: \.self) { cate in
                                        HStack {
                                            Text(cate)
                                            Button {
                                                let c = category.filter({ $0 != cate })
                                                withAnimation(.easeInOut(duration: 0.5)){
                                                    category.removeAll()
                                                    category = c
                                                }
                                            } label: {
                                                Image(systemName: "multiply")
                                            }
                                        }
                                        .padding(5)
                                        .background(Color(color2))
                                        .foregroundColor(!isDark ? .black : .white)
                                        .cornerRadius(20)
                                        .shadow(radius: 2)
                                        .padding(5)
                                    }
                                    
                                    Button{
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            categoryBtn.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "plus.circle")
                                            .font(.title2)
                                            .foregroundColor(!isDark ? .secondary : .white)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Actors: ")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(actors, id: \.self) { act in
                                        HStack {
                                            Text(act)
                                            Button {
                                                let c = actors.filter({ $0 != act })
                                                withAnimation(.easeInOut(duration: 0.5)){
                                                    actors.removeAll()
                                                    actors = c
                                                }
                                            } label: {
                                                Image(systemName: "multiply")
                                            }
                                        }
                                        .padding(5)
                                        .background(Color(color2))
                                        .foregroundColor(!isDark ? .black : .white)
                                        .cornerRadius(20)
                                        .shadow(radius: 2)
                                        .padding(5)
                                    }

                                    Button{
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            actorBtn.toggle()
                                        }
                                        
                                    } label: {
                                        Image(systemName: "plus.circle")
                                            .font(.title2)
                                            .foregroundColor(!isDark ? .secondary : .white)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        
                        Button {
                            let imageUrl = uploadImage()
                            if imageUrl != "" && name != "" && description != "" {
                                if url.count > 0 {
                                    self.movieModel.addMovie(imageUrl: imageUrl, trailerUrl: url[0].url!, name: name, age: age, published: published, category: category, owner: user, description: description, director: director, actors: actors)
                                } else {
                                    self.movieModel.addMovie(imageUrl: imageUrl, trailerUrl: "", name: name, age: age, published: published, category: category, owner: user, description: description, director: director, actors: actors)
                                }
                                
                                deleteAllVideo()
                                status3.toggle()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                                    // your code here
                                    
                                    isUse.toggle()
                                    status3.toggle()
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            } else {
                                status3.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                    // your code here
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        status3.toggle()
                                    }
                                }
                            }
                            
                            
                        } label: {
                            Text("Save")
                                .font(.title)
                                .padding(5)
                                .padding(.horizontal)
                                .background(Color(color2))
                                .foregroundColor(!isDark ? .black : .white)
                                .cornerRadius(20)
                                .shadow(radius: 3)
                        }
                        .padding()
                        
                    }
                }
                .disabled(status || status2 || status3 || categoryBtn || actorBtn)
                .opacity(status || status2 || status3 || categoryBtn || actorBtn ? 0.5 : 1)
                
                if status {
                    AceptButton
                        .transition(.move(edge: .bottom))
                }
                
                if status2 {
                    LoadingForever()
                }
                
                if status3 {
                    if name != "" && description != "" && image1 != UIImage() {
                        LoadingAnimation(status: true)
//                    } else {
                        VStack {
                            LoadingAnimation(status: false)
                            
                            Text("Image, name movie, or description haven't added yet!!")
                                .font(.title)
                                .foregroundColor(.red)
                                .opacity(dis ? 0 : 1)
                                .onAppear(){
                                    withAnimation(.easeInOut(duration: 0.3).delay(1.8)){
                                        dis.toggle()
                                    }
                                    withAnimation(.easeInOut(duration: 0.5).delay(5.0)){
                                        dis.toggle()
                                    }
                                }
                        }
                    }
                    
                }
                
                if categoryBtn {
                    CategoryButon
                        .transition(.move(edge: .bottom))
                }
                
                if actorBtn {
                    ActorButon
                        .transition(.move(edge: .bottom))
                }
            }
            .onReceive(timer){ _ in
                if videoPicker.selectedItem != nil {
                    status = false
                    status2 = true
                    count += 1
                    getAllVideo()
                }
                
                if count == 5 {
                    status2 = false
                    status1 = true
                    videoPicker.deleteSelectItem()
                }
            }
            .navigationBarBackButtonHidden(true)
            // Add your custom back button here
            .navigationBarItems(leading:
                                    Button(action: {
                Task {
                    if url.count > 0 {
                        try await videoPicker.deleteVideoByLink(link: url[0].url ?? "")
                    }
                }
                deleteAllVideo()
                isUse.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(isDark ? .white : .gray)
                        .disabled(status || status2 || categoryBtn || status3 || actorBtn)
                        .opacity(status || status2 || categoryBtn || status3 || actorBtn ? 0.5 : 1)
                }
            }
                .disabled(status || status2 || categoryBtn || status3 || actorBtn)
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add your Movie")
                        .font(.title.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
    }
    
    var AceptButton: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.75)
            VStack {
                Button {
                    shouldShowVideoPicker.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .photosPicker(isPresented: $shouldShowVideoPicker, selection: $videoPicker.selectedItem ,matching: .videos)
                
                Text("Choosing trailer ? Carefully, you can't choose again after the choice!! ")
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .overlay(
          Button(action: {
              withAnimation(.easeInOut(duration: 0.5)) {
                  status.toggle()
              }
          }) {
            Image(systemName: "xmark.circle")
              .font(.title)
              .foregroundColor(!isDark ? .gray : .white)
          }
          .padding(.top, 20)
          .padding(.trailing, 20),
          alignment: .topTrailing
          )
    }
    
    var CategoryButon: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.75)
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    Group {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                category.append("Action")
                                categoryBtn.toggle()
                            }
                        } label: {
                            Text("Action")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                category.append("Fiction")
                                categoryBtn.toggle()
                            }
                        } label: {
                            Text("Fiction")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                category.append("Romance")
                                categoryBtn.toggle()
                            }
                        } label: {
                            Text("Romance")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                category.append("Fantasy")
                                categoryBtn.toggle()
                            }
                        } label: {
                            Text("Fantasy")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                category.append("Mystery")
                                categoryBtn.toggle()
                            }
                        } label: {
                            Text("Mystery")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                category.append("Adventure")
                                categoryBtn.toggle()
                            }
                        } label: {
                            Text("Adventure")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)){
                            category.append("Anime/Family")
                            categoryBtn.toggle()
                        }
                    } label: {
                        Text("Anime/Family")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)){
                            category.append("Thiller")
                            categoryBtn.toggle()
                        }
                    } label: {
                        Text("Thiller")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)){
                            category.append("Comedy")
                            categoryBtn.toggle()
                        }
                    } label: {
                        Text("Comedy")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)){
                            category.append("Horror")
                            categoryBtn.toggle()
                        }
                    } label: {
                        Text("Horror")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)){
                            category.append("Drama")
                            categoryBtn.toggle()
                        }
                    } label: {
                        Text("Drama")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
        .overlay(
          Button(action: {
              withAnimation(.easeInOut(duration: 0.5)) {
                  categoryBtn.toggle()
              }
          }) {
            Image(systemName: "xmark.circle")
              .font(.title)
          }
          .foregroundColor(.white)
          .padding(.top, 20)
          .padding(.trailing, 20),
          alignment: .topTrailing
          )
    }
    
    var ActorButon: some View {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.75)
                VStack {
                    HStack {
                        Text("Actor name: ")
                            .foregroundColor(.white)
                        TextField("name", text: $actor)
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .font(.title)
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)){
                            if actor != "" {
                                actors.append(actor)
                            }
                            actorBtn.toggle()
                        }
                        self.actor = ""
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .overlay(
              Button(action: {
                  withAnimation(.easeInOut(duration: 0.5)) {
                      self.actor = ""
                      actorBtn.toggle()
                  }
              }) {
                Image(systemName: "xmark.circle")
                  .font(.title)
              }
              .foregroundColor(.white)
              .padding(.top, 20)
              .padding(.trailing, 20),
              alignment: .topTrailing
              )
    }
    
    func getAllVideo() {
        Firestore.firestore().collection("videos").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { return }
            
            self.url = documents.map { (queryDocumentSnapshot) -> Video in
                
                let data = queryDocumentSnapshot.data()
                let url = data["videoUrl"] as? String ?? ""
                return Video(url: url, documentID: queryDocumentSnapshot.documentID)
            }
        }
    }
    
    func deleteAllVideo() {
        for u in url {
            if u.documentID != nil {
                Firestore.firestore().collection("videos").document(u.documentID!).delete()
            }
        }
    }
    
    func uploadImage() -> String {
        guard image1 != nil else {
            return ""
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = image1!.jpegData(compressionQuality: 0.8)
        
        let path = "MoviesImage/\(UUID().uuidString).jpg"
        
        let fileRef = storageRef.child(path)
        
        let _ = fileRef.putData(imageData!, metadata: nil) { metadata, error in }
        
        return path
    }
    
    
}

struct AddMoviePage_Previews: PreviewProvider {
    static var previews: some View {
        AddMoviePage(isUse: .constant(true))
    }
}
