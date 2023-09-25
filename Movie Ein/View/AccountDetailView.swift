//
//  AccountDetailView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 09/09/2023.
//

import SwiftUI
import FirebaseStorage

struct AccountDetailView: View {
    @AppStorage("user") var user = ""
    @AppStorage("isDark") var isDark = false
    @AppStorage("login") var loginSuccess = false
    @State private var status = false
    
    @Binding var btn: Bool
    
    @StateObject private var accountModel = AccountModel()
    @State private var index = 1
    @State private var btnLogin = false
    @AppStorage("statusLogin") var statusLogin = false
    @State private var isEdit = false
    @State private var isEdition = false
    @State var imageRecieve = UIImage()
    
    var body: some View {
        if loginSuccess {
            NavigationStack {
                ZStack {
                    Group {
                        detail
                            .transition(.move(edge: .trailing))
                            .blur(radius: isEdit ? 10 : 0)
                            .disabled(isEdit)
                            .onAppear {
                                btn = false
                            }
                    }
                    .onChange(of: isEdit) { _ in
                        if !isEdit {
                            btn = false
                        } else {
                            btn = true
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
                                            Menu {
                        Button("Log out"){
                            withAnimation(.easeInOut(duration: 0.5)){
                                loginSuccess = false
                            }
                            user = ""
                        }
                        Button("Edit detail"){
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isEdit.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title3)
                            .foregroundColor(isDark ? .white : .gray)
                    }
                        .disabled(isEdit)
                        .opacity(isEdit ? 0.5 : 1)
                    )
                    if isEdit {
                        editPage
                        //.transition(.move(edge: .bottom))
                            .opacity(isEdition ? 0.5 : 1)
                            .blur(radius: isEdition ? 1 : 0)
                            .disabled(isEdition)
                        if isEdition {
                            LoadingAnimation(status: true)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        // your code here
                                        isEdition.toggle()
                                        withAnimation(.easeInOut(duration: 0.5)){
                                            isEdit.toggle()
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        } else {
            NavigationStack {
                ZStack {
                    content
                        .opacity(btnLogin ? 0.5 : 1)
                        .blur(radius: btnLogin ? 4 : 0)
                        .disabled(btnLogin)
                    if btnLogin {
                        LoadingAnimation(status: statusLogin)
                    }
                }
                .onChange(of: btnLogin) { _ in
                    if btnLogin {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                            // your code here
                            btnLogin.toggle()
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
            }
        }
    }
    
    var content: some View {
        ZStack{
            BackgroundPage()
            Group{
                VStack {
                    HStack {
                        Text("Register or login to enjoy more service")
                            .foregroundColor(!isDark ? .black : .white)
                            .font(.system(size: 57, weight: .heavy, design: .rounded))
                            .padding(.top, 100)
                            .padding(.leading, 28)
                        Spacer ()
                    }
                    
                    HStack{
                        Text("We are waiting for you and welcome to our big family!!")
                            .foregroundColor(!isDark ? .black : .white)
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .padding()
                            .padding(.horizontal, 15)
                        Spacer()
                    }
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
                    .padding(.bottom, 80)
                }
                
            }
            .blur(radius: btn ? 10 : 0)
            .disabled(btn)
            
            if btn {
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
    }
    
    var detail: some View {
        let color1 = isDark ? "Gray" : "WhiteYellow"
        let color = "Gray"
        let color2 = isDark ? "Dark1" : "WhiteYellow2"
        var account = accountModel.getAccountByUserName(UserName: user)
        return GeometryReader { geometry in
            ZStack {
                BackgroundPage()
                VStack {
                    HStack {
                        ZStack {
                            Color(color)
                                .scaledToFit()
                                .frame(width: 140)
                                .cornerRadius(20)
                                .shadow(radius: 4)
                                .padding(.horizontal, 10)
                                .opacity(0.6)
                                .offset(x: -10, y: -10)
                            Color(color1)
                                .scaledToFit()
                                .frame(width: 140)
                                .cornerRadius(20)
                                .shadow(radius: 4)
                                .padding(.horizontal, 10)
                                .opacity(0.6)
                            if account.url == "" {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 60).stroke(isDark ? .white : .black, lineWidth: 3)
                                    )
                            } else {
                                if account.url != nil {
                                    Image(uiImage: imageRecieve)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(!isDark ? Color.black : Color.white, lineWidth: 3))
                                        .onAppear {
                                            retrievedImage()
                                        }
                                        .onChange(of: isEdition) { _ in
                                            retrievedImage()
                                        }
                                }
                            }
                        }
                        VStack {
                            HStack {
                                Group {
                                    if account.name == "" {
                                        Text("User 123")
                                    } else {
                                        if let name = account.name {
                                            Text(name)
                                        }
                                    }
                                }
                                .font(.system(size: 26))
                                .foregroundColor(isDark ? .white : .black)
                                
                                Spacer()
                            }
                            .padding(.vertical, 1)
                            
                            HStack {
                                Group {
                                    if account.job == "" {
                                        Text("Job")
                                    } else {
                                        if let job = account.job {
                                            Text(job)
                                        }
                                    }
                                }
                                .font(.system(size: 16))
                                .foregroundColor(isDark ? .white : .black)
                                
                                Spacer()
                            }
                            .padding(.vertical, 1)
                            
                            HStack {
                                if account.documentID != nil {
                                    Group {
                                        Text("User ID: \(account.documentID!)")
                                    }
                                    .font(.system(size: 9))
                                    .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 1)
                        }
                    }
                    .padding()
                    .padding(.top, 20)
                    
                    Divider()
                    ZStack {
                        Color(color2)
                            .frame(width: geometry.size.width * 0.93, height: 45)
                            .cornerRadius(10)
                            .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                            .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        HStack {
                            Text("The Information")
                                .padding(.vertical, 5)
                                .frame(width: geometry.size.width * 0.9)
                                .background(Color(color2))
                                .cornerRadius(10)
                                .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                                .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        }
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Group {
                            if account.userName != nil {
                                Text("Email: \(account.userName!)")
                                    .padding(5)
                            } else {
                                Text("Email:")
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(Color(color2))
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                        .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        
                        Spacer()
                    }
                    .font(.system(size: 20))
                    .padding(20)
                    .frame(width: geometry.size.width)
                    
                    HStack {
                        Group {
                            if account.birth != nil {
                                Text("Birth: \(account.birth!)")
                                    .padding(5)
                            } else {
                                Text("Birth: ")
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(Color(color2))
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                        .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        
                        Spacer()
                    }
                    .font(.system(size: 20))
                    .padding(20)
                    .frame(width: geometry.size.width)
                    
                    HStack {
                        Group {
                            if account.age != nil {
                                Text("Age: \(account.age!)")
                                    .padding(5)
                            } else {
                                Text("Age: ")
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(Color(color2))
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                        .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        
                        Spacer()
                        
                        Group {
                            if account.sex != nil {
                                Text("Sex: \(account.sex!)")
                                    .padding(5)
                            } else {
                                Text("Sex: ")
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(Color(color2))
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                        .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        
                        Spacer()
                    }
                    .font(.system(size: 20))
                    .padding(20)
                    .frame(width: geometry.size.width)
                    
                    HStack {
                        Group {
                            if account.address != nil {
                                Text("Address: \(account.address!)")
                                    .padding(5)
                            } else {
                                Text("Address: ")
                                    .padding(5)
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(Color(color2))
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.1), radius: 10, x: -8, y: -8)
                        .shadow(color: Color.black.opacity(0.13), radius: 10, x: 8, y: 8)
                        
                        Spacer()
                    }
                    .font(.system(size: 20))
                    .padding(20)
                    .frame(width: geometry.size.width)
                    
                    Spacer()
                    
                }
            }
            .onChange(of: isEdition) { _ in
                withAnimation(.easeInOut(duration: 0.3)){
                    account = accountModel.getAccountByUserName(UserName: user)
                }
            }
            .onAppear() {
                withAnimation(.easeInOut(duration: 0.3)){
                    account = accountModel.getAccountByUserName(UserName: user)
                }
            }
            
        }
        
        func retrievedImage() {
            let storageRef = Storage.storage().reference()
            if account.url != nil {
                
                let fileRef = storageRef.child(account.url!)
                
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    
                    if error == nil && data != nil {
                        
                        if let image = UIImage(data: data!) {
                            
                            DispatchQueue.main.async {
                                imageRecieve = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    var editPage: some View {
        ZStack {
            EditAccountView(isEdition: $isEdition)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)){
                            isEdit.toggle()
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
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView(btn: .constant(false))
    }
}
