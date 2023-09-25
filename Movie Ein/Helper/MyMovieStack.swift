//
//  MyMovieStack.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 16/09/2023.
//

import SwiftUI
import FirebaseStorage

struct MyMovieStack: View {
    @AppStorage("user") var user = ""
    @AppStorage("isDark") var isDark = false
    @State var movie: Movie
    @State var image = UIImage()
    @State var imgWidth: CGFloat
    @State var imgHeigh: CGFloat
    @State var status: Bool
    
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: imgWidth, height: imgHeigh)
                .cornerRadius(5.0)
                .shadow(radius: 3)
                .onAppear() {
                    retrievedImage()
                }
            
            if movie.name != nil && status {
                Text(movie.name!)
                    .foregroundColor(!isDark ? .black : .white)
                    .font(.system(size: 12))
                    .fontWeight(.light)
            }
        }
        .frame(width: imgWidth)
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

struct MyMovieStack_Previews: PreviewProvider {
    static var previews: some View {
        MyMovieStack(movie: Movie(), imgWidth: 100.0, imgHeigh: 100.0, status: true)
    }
}
