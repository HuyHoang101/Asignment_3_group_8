//
//  MyMovieRow.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 17/09/2023.
//

import SwiftUI
import FirebaseStorage

struct MyMovieRow: View {
    @AppStorage("user") var user = ""
    @AppStorage("isDark") var isDark = false
    @State var movie: Movie
    @State var image = UIImage()
    @State var imgSize: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            Image(uiImage: image)
                .resizable()
                .frame(width: imgSize, height: imgSize * 1.45)
                .cornerRadius(10.0)
                .shadow(radius: 3)
                .onAppear() {
                    retrievedImage()
                }
            VStack {
                Spacer()
                HStack {
                    if movie.name != "" {
                        Text(movie.name!)
                            .foregroundColor(Color(isDark ? .white : .black))
                            .font(.system(size: 24))
                            .bold()
                    }
                    Spacer()
                }
                .padding(.leading)
                Spacer()
                HStack {
                    Text(movie.published!, format: .dateTime.year())
                        .foregroundColor(Color(isDark ? .white : .black))
                        .padding(.trailing)
                        .font(.system(size: 11))
                    Text("\(movie.age!)+")
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .background(.secondary)
                        .font(.system(size: 11))
                        .cornerRadius(3)
                    Spacer()
                }
                .padding(.leading)
                Spacer()
                HStack {
                    if movie.description != "" {
                        Text(movie.description!)
                            .foregroundColor(isDark ? .white : .black)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding(.leading)
                Spacer()
            }
        }
    }
    
    func retrievedImage() {
        let storageRef = Storage.storage().reference()
        if movie.ImageUrl != "" {
            let fileRef = storageRef.child(movie.ImageUrl!)
            
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                
                if error == nil && data != nil {
                    
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        }
    }
}


struct MyMovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MyMovieRow(movie: Movie(), imgSize: 100)
    }
}
