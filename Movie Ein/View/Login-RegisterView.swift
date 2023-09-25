//
//  Login-RegisterView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 09/09/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Login_RegisterView: View {
    @AppStorage("isDark") var isDark = false
    @AppStorage("login") var loginSuccess = false
    @AppStorage("user") var user = ""
    @State private var log = false
    @State private var sig = false
    @State var signUpSuccess = false
    @State var email = ""
    @State var password = ""
    @State private var isSignUp = false
    @State private var status = false
    @Binding var btn: Bool
    @AppStorage("statusLogin") var statusLogin = false
    @State var passwordConfirmation = ""
    @StateObject private var accountModel = AccountModel()
    @StateObject private var myContactModel = MyContactModel()
    
    var body: some View {
        let color1 = isDark ? "Gray" : "WhiteYellow"
        ZStack{
            VStack{
                Group {
                    if !status {
                        Text("Login")
                    } else {
                        Text("Sign Up")
                    }
                }
                .foregroundColor(!isDark ? .black : .white)
                .font(.system(size: 46, weight: .heavy, design: .rounded))
                .padding()
                .shadow(radius: 3)
                ZStack{
                    Color(color1)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .frame(width: 350, height: isSignUp ? 440 : 350)
//                        .shadow(radius: 3)
//                        .opacity(0.6)
                        .padding()
                    VStack {
                        Group {
                            HStack {
                                Text("Email")
                                    .foregroundColor(!isDark ? .black : .white)
                                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "paperplane.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(color1))
                                    .opacity(0.7)
                                TextField("Email", text: $email)
                                
                                Spacer()
                            }
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            HStack {
                                Text("Password")
                                    .foregroundColor(!isDark ? .black : .white)
                                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                                    .padding(.horizontal)
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "lock.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(color1))
                                    .opacity(0.7)
                                SecureField("Password", text: $password)
                                
                                Spacer()
                            }
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            if isSignUp {
                                HStack {
                                    Text("Comfirm Password")
                                        .foregroundColor(!isDark ? .black : .white)
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                HStack {
                                    Image(systemName: "lock.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color(color1))
                                        .opacity(0.7)
                                    SecureField("Comfirm Password", text: $passwordConfirmation)
                                    
                                    Spacer()
                                }
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        // Login button
                        Button {
                            if isSignUp {
                                signUp()
                            } else {
                                login()
                            }
                            btn.toggle()
                        } label: {
                            Group {
                                if status{
                                    Text("Sign up")
                                }else {
                                    Text("Sign in")
                                }
                            }
                            .bold()
                            .foregroundColor(!isDark ? Color(.gray) : Color(color1))
                            .frame(width: 150, height: 45)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .padding()
                        }
                        
                        Spacer()
                        
                        // Button to show the sign up sheet
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)){
                                isSignUp.toggle()
                            }
                            status.toggle()
                            log = false
                            sig = false
                        } label: {
                            Group {
                                if !status {
                                    Text("Sign Up Here!")
                                } else {
                                    Text("Go to Login!")
                                }
                            }
                            .foregroundColor(!isDark ? .gray : .white)
                        }
                    }
                    .padding()
                    .frame(width: 350, height: isSignUp ? 320 : 260)
                    
                }
            }
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                signUpSuccess = false
                sig = false
                statusLogin = false
                
            } else {
                print("success")
                signUpSuccess = true
                self.accountModel.addAccount(userName: email)
                self.myContactModel.addContact(userName: email)
                sig = true
                statusLogin = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                loginSuccess = false
                log = false
                statusLogin = false
            } else {
                statusLogin = true
                print("success")
                log = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    withAnimation(.easeInOut(duration: 0.4)){
                        loginSuccess = true
                    }
                }
                user = email
            }
        }
    }
}


struct Login_RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Login_RegisterView(btn: .constant(false))
    }
}
