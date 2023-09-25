//
//  EditAccountView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 13/09/2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct EditAccountView: View {
    @AppStorage("isDark") var isDark = false
    @AppStorage("user") var user = ""
    @StateObject private var accountModel = AccountModel()
    @StateObject private var imageModel = ImageModel()
    @State var name = String()
    @State var age = ""
    @State var sex = ""
    @State var birth = ""
    @State var job = ""
    @State var address = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State var imageRecieve = UIImage()
    
    @Binding var isEdition: Bool
    
    var body: some View {
        let color1 = isDark ? "Dark1" : "WhiteYellow"
        let color2 = isDark ? "Dark" : "WhiteYellow2"
        let account = accountModel.getAccountByUserName(UserName: user)
        
        return GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Color(color2)
                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.7)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .shadow(radius: 4)
                            
                            Spacer()
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                            imageView
                            Spacer()
                        }
                        Group {
                            HStack{
                                Spacer()
                                Text("Name: ")
                                TextField(account.name ?? "name", text: $name)
                                    .padding(.trailing, 10)
                                    .foregroundColor(.black)
                                    .background(Color(color1))
                                    .frame(width: geometry.size.width * 0.6)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .onAppear() {
                                        print("true")
                                        if let n = account.name {
                                            self.name = n
                                        }
                                    }
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            HStack{
                                Spacer()
                                Text("Age: ")
                                TextField(account.age ?? "age", text: $age)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 10)
                                    .background(Color(color1))
                                    .frame(width: geometry.size.width * 0.19)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .onAppear() {
                                        if account.age != nil {
                                            self.age = account.age!
                                        }
                                    }
                                Spacer()
                                Text("Sex: ")
                                TextField(account.sex ?? "sex", text: $sex)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 10)
                                    .background(Color(color1))
                                    .frame(width: geometry.size.width * 0.19)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .onAppear() {
                                        if account.sex != nil {
                                            self.sex = account.sex!
                                        }
                                    }
                                
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            HStack{
                                Spacer()
                                Text("Birth: ")
                                
                                TextField(account.birth ?? "birth", text: $birth)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 10)
                                    .background(Color(color1))
                                    .frame(width: geometry.size.width * 0.6)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .onAppear() {
                                        if account.birth != nil {
                                            self.birth = account.birth!
                                        }
                                    }
                                    
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            HStack{
                                Spacer()
                                Text("Job: ")
                                
                                TextField(account.job ?? "job", text: $job)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 10)
                                    .background(Color(color1))
                                    .frame(width: geometry.size.width * 0.6)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .onAppear() {
                                        if account.job != nil {
                                            self.job = account.job!
                                        }
                                    }
                                
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            HStack{
                                Spacer()
                                Text("Address: ")
                                TextField(account.address ?? "address", text: $address)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 10)
                                    .background(Color(color1))
                                    .frame(width: geometry.size.width * 0.5)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .onAppear() {
                                        if account.address != nil {
                                            self.address = account.address!
                                        }
                                    }
                                
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                        .foregroundColor(isDark ? .white : .gray)
                        
                    }
                }
//                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
//                    ImagePicker(image: $image)
//                }
                Button {
                    if account.userName != nil {
                        uploadData(with: account.userName!)
                    }
                    isEdition.toggle()
                } label: {
                    Text("Save")
                }
                .frame(width: 80 , height: 40)
                .background(Color(color1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 3)
                .padding()
                
                Spacer()
            }
            .padding(.top, 80)
            .foregroundColor(isDark ? .white : .gray)
        }
        
        func readName() {
            if account.name != nil {
                DispatchQueue.main.async {
                    self.name = account.name!
                }
            }
        }
    }
    
    var imageView: some View {
        let account = accountModel.getAccountByUserName(UserName: user)
        
        return
            Button {
                shouldShowImagePicker.toggle()
            } label: {
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120,height: 120)
                        .cornerRadius(60)
                        .shadow(radius: 3)
                        .overlay(){
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(!isDark ?  Color.black : Color.white, lineWidth: 2)
                        }
                        .padding()
                } else {
                    if account.url != nil {
                        Image(uiImage: imageRecieve)
                            .resizable()
                            .frame(width: 120,height: 120)
                            .cornerRadius(60)
                            .shadow(radius: 3)
                            .overlay(){
                                RoundedRectangle(cornerRadius: 60)
                                    .stroke(!isDark ?  Color.black : Color.white, lineWidth: 2)
                            }
                            .onAppear() {
                                retrievedImage()
                            }
                            .padding()
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .foregroundColor(isDark ? .white : .secondary)
                            .scaledToFit()
                            .frame(width: 120)
                            .padding()
                    }
                }
            }
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
                ImagePicker(image: $image)
            }
        
        func retrievedImage() {
            let storageRef = Storage.storage().reference()
            if account.url != nil {
                
                let fileRef = storageRef.child(account.url!)
                
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    
                    if error == nil && data != nil {
                        
                        if let image = UIImage(data: data!) {
                            
                            DispatchQueue.main.async {
                                self.imageRecieve = image
                            }
                        }
                    }
                }
            }
        }
        }
    
    
    func uploadData(with userName: String) {
        guard image != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
//        guard imageData != nil else {
//            return
//        }
        
        let path = "AccountImage/\(UUID().uuidString).jpg"
        
        let fileRef = storageRef.child(path)
        
        let db = Firestore.firestore()
        
        db.collection("Accounts").whereField("userName", isEqualTo: userName).getDocuments { (snap, err) in
            
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                if name != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["name":name])
                    }
                }
                if age != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["age":age])
                    }
                }
                if sex != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["sex":sex])
                    }
                }
                if birth != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["birth":birth])
                    }
                }
                if job != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["job":job])
                    }
                }
                if address != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["address":address])
                    }
                }
                let _ = fileRef.putData(imageData!, metadata: nil) { metadata, error in
                    
                    if error == nil && metadata != nil {
                        DispatchQueue.main.async {
                            i.reference.updateData(["url":path])
                        }
                    }
                    
                }
            }
        }
    }

}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView(isEdition: .constant(true))
    }
}
