//
//  Account Animation.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 20/09/2023.
//

import SwiftUI
import FirebaseStorage

struct AccountAnimation: View {
    @AppStorage("isDark") var isDark = false
    @State private var img = UIImage()
    @State var account: Account
    @State var imgSize: CGFloat
    @Namespace private var namespace
    @Namespace private var namespaceImage
    @Namespace private var namespaceText
    @State private var btn = false
    
    var body: some View {
        VStack {
            HStack {
                ImageAccount
                    .frame(width: btn ? imgSize : imgSize * 0.55)
                if !btn {
                    VStack {
                        HStack {
                            textName
                                .matchedGeometryEffect(id: namespaceText, in: namespace)
                            Spacer()
                        }
                        .font(.title2)
                        
                        Spacer()
                        
                        HStack {
                            Text("UserID: \(account.documentID!)")
                                .foregroundColor(.secondary)
                                .font(.system(size: 11))
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("Gmail: \(account.userName!)")
                                .foregroundColor(.secondary)
                                .font(.system(size: 13))
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .frame(height: imgSize * 0.5)
                    .padding(.leading, 10)
                    
                    Spacer()
                }
            }
            if btn {
                textName
                    .matchedGeometryEffect(id: namespaceText, in: namespace)
                    .padding(.top, 15)
            }
        }
        .padding(.horizontal)
        .padding(.top, 25)
    }
    
    var ImageAccount: some View {
        return Group {
            if account.url == "" {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
            } else {
                if account.url != nil {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(!isDark ? Color.black : Color.white, lineWidth: 3))
                        .onAppear {
                            retrievedImage(url: account.url)
                        }
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                btn.toggle()
            }
        }
    }
    
    var textName: some View {
        return Group {
            if account.name == "" {
                Text("User 123")
                    .font(.title2)
            } else {
                Text("\(account.name!)")
                    .font(.title2)
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

struct AccountAnimation_Previews: PreviewProvider {
    static var previews: some View {
        AccountAnimation(account: Account(userName: "Example@gmail.com", name: "Lily White", age: "", birth: "", sex: "", job: "", address: "", url: "", documentID: UUID().uuidString), imgSize: 200)
    }
}
