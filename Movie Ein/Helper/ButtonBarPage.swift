//
//  ButtonBarPage.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 15/09/2023.
//

import SwiftUI

struct ButtonBarPage: View {
    
    @Binding var isPage: Int
    @Binding var isExit: Bool
    
    @AppStorage("isDark") var isDark = false
    @State var isChange = false // if clicked by user
    @Namespace var namespace
    @Namespace var namespacebutton
    
    var body: some View {
        let color2 = isDark ? "Gray1" : "WhiteYellow2"
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    if isChange {
                        HStack{
                            Spacer()
                            Button(action: {
                                isExit.toggle()
                            }) {
                                if isChange {
                                    Image(systemName: "xmark.circle")
                                        .font(.title)
                                } else {
                                    Image(systemName: "plus.circle")
                                        .font(.title)
                                        .bold()
                                }
                            }
                            .foregroundColor(!isDark ? Color("TheBlue") : .white)
                            .shadow(color: Color(.gray).opacity(0.4), radius: 3)
                            .matchedGeometryEffect(id: namespacebutton, in: namespace)
                        }
                        .padding(.horizontal)
                        .onChange(of: isExit){ _ in
                            if isExit {
                                withAnimation(.easeInOut(duration: 0.5).delay(0.2)){
                                    isChange = true
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.5).delay(0.2)){
                                    isChange = false
                                }
                            }
                        }
                    }
                    HStack {
                        Spacer()
                        
                        ZStack{
                            Color(color2)
                                .frame(width: isChange ? geometry.size.width * 0.9 : 0, height: isChange ? 55 : 0)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation(.easeInOut(duration: 0.3)){
                                        isPage = 1
                                    }
                                } label: {
                                    VStack{
                                        if isPage == 1 {
                                            Color("TheBlue")
                                                .frame(width: isChange ? geometry.size.width * 0.25 : 0, height: isChange ? 3 : 0)
                                                .matchedGeometryEffect(id: "bar", in: namespace)
                                        }
                                        Spacer()
                                        if isPage == 1 {
                                            Text("Home")
                                                .bold()
                                                .font(.system(size: 20))
                                                .foregroundColor(Color("TheBlue"))
                                                .opacity(!isChange ? 0 : 1)
                                                .matchedGeometryEffect(id: "text1", in: namespace)
                                        } else {
                                            Text("Home")
                                                .foregroundColor(!isDark ? .black : .white)
                                                .opacity(!isChange ? 0 : 1)
                                                .matchedGeometryEffect(id: "text1", in: namespace)
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                    .frame(width: isChange ? geometry.size.width * 0.25 : 0, height: isChange ? 55 : 0)
                                }
                                Spacer()
                                Button {
                                    withAnimation(.easeInOut(duration: 0.3)){
                                        isPage = 2
                                    }
                                } label: {
                                    VStack{
                                        if isPage == 2 {
                                            Color("TheBlue")
                                                .frame(width: isChange ? geometry.size.width * 0.25 : 0, height: isChange ? 3 : 0)
                                                .matchedGeometryEffect(id: "bar", in: namespace)
                                        }
                                        Spacer()
                                        if isPage != 2 {
                                            Text("My Movie")
                                                .foregroundColor(!isDark ? .black : .white)
                                                .opacity(!isChange ? 0 : 1)
                                                .matchedGeometryEffect(id: "text2", in: namespace)
                                        } else {
                                            Text("My Movie")
                                                .bold()
                                                .font(.system(size: 20))
                                                .foregroundColor(Color("TheBlue"))
                                                .opacity(!isChange ? 0 : 1)
                                                .matchedGeometryEffect(id: "text2", in: namespace)
                                        }
                                        Spacer()
                                    }
                                    .frame(width: isChange ? geometry.size.width * 0.25 : 0, height: isChange ? 55 : 0)
                                }
                                Spacer()
                                Button {
                                    withAnimation(.easeInOut(duration: 0.3)){
                                        isPage = 3
                                    }
                                } label: {
                                    VStack{
                                        if isPage == 3 {
                                            Color("TheBlue")
                                                .frame(width: isChange ? geometry.size.width * 0.25 : 0, height: isChange ? 3 : 0)
                                                .matchedGeometryEffect(id: "bar", in: namespace)
                                        }
                                        Spacer()
                                        if isPage == 3 {
                                            Text("Account")
                                                .bold()
                                                .font(.system(size: 20))
                                                .foregroundColor(Color("TheBlue"))
                                                .opacity(!isChange ? 0 : 1)
                                                .matchedGeometryEffect(id: "text3", in: namespace)
                                        } else {
                                            Text("Account")
                                                .foregroundColor(!isDark ? .black : .white)
                                                .opacity(!isChange ? 0 : 1)
                                                .matchedGeometryEffect(id: "text3", in: namespace)
                                        }
                                        
                                        Spacer()
                                    }
                                    .frame(width: isChange ? geometry.size.width * 0.25 : 0, height: isChange ? 55 : 0)
                                }
                                Spacer()
                            }
                            .frame(width: isChange ? geometry.size.width * 0.9 : 0)
                        }
                        .padding(.trailing, geometry.size.width * 0.05)
                        .opacity(!isChange ? 0 : 1)
                        
                        
                    }
                    .padding(.bottom)
                    .disabled(!isChange)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if !isChange {
                            HStack{
                                Spacer()
                                Button(action: {
                                    isExit.toggle()
                                }) {
                                    if isChange {
                                        Image(systemName: "xmark.circle")
                                            .font(.title)
                                    } else {
                                        Image(systemName: "plus.circle")
                                            .font(.title)
                                            .bold()
                                    }
                                }
//                                .foregroundColor(!isDark ? .gray : .white)
                                .foregroundColor(!isDark ? Color("TheBlue") : .white)
                                .shadow(color: Color.gray.opacity(0.4), radius: 3)
                                .matchedGeometryEffect(id: namespacebutton, in: namespace)
                            }
                            .padding(.horizontal)
                            .onChange(of: isExit){ _ in
                                if isExit {
                                    withAnimation(.easeInOut(duration: 0.5).delay(0.2)){
                                        isChange = true
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.5).delay(0.2)){
                                        isChange = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ButtonBarPage_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBarPage(isPage: .constant(1), isExit: .constant(true))
    }
}
