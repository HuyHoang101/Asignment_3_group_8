//
//  FilterContact.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 19/09/2023.
//

import SwiftUI

struct FilterContact: View {
    @State var isWidth: CGFloat
    @Binding var isContact: String
    @State private var background = false
    @State private var btn = false
    @State private var btn1 = false
    @State private var btn2 = false
    @State private var btn3 = false
    @State private var contains = false
    @AppStorage("isDark") var isDark = false
    @Namespace var namespace
    @Namespace var namespacebackground
    
    var body: some View {
        ZStack {
            Color(isDark ? "Dark1" : "WhiteYellow3")
                .frame(width: isWidth,height: background ? isWidth * 0.95 : isWidth / 5)
                .cornerRadius(isWidth / 10)
                .shadow(radius: 3)
                .matchedGeometryEffect(id: namespacebackground, in: namespace)
            if contains {
                VStack {
                    if btn {
                        Spacer()
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                                    btn.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                                    btn1.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.15)) {
                                    btn2.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    btn3.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    background.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    contains.toggle()
                                }
                            } label: {
                                Group {
                                    HStack {
                                        Text(isContact == "isLike" ? "Movies Liked" : isContact == "isSuprise" ? "Movies Suprised" : "Movies Rated")
                                            .padding(.leading, 10)
                                        Spacer()
                                        Image(systemName: "slider.horizontal.3")
                                            .padding(.trailing, 10)
                                    }
                                }
                                .font(.title3)
                            }
                        }
                        .matchedGeometryEffect(id: "text", in: namespace)
                    }
                    Spacer()
                    Divider()
                    if btn1 {
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                                    btn.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                                    btn1.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.15)) {
                                    btn2.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    btn3.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    background.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    contains.toggle()
                                    isContact = "isLike"
                                }
                            } label: {
                                Group {
                                    HStack {
                                        Text("Movies Liked")
                                            .padding(.leading, 10)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .padding(.trailing, 10)
                                    }
                                }
                                .font(.title3)
                            }
                        }
                        .transition(.move(edge: .top))
                    }
                    Spacer()
                    if btn2 {
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                                    btn.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                                    btn1.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.15)) {
                                    btn2.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    btn3.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    background.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    contains.toggle()
                                    isContact = "isSuprise"
                                }
                            } label: {
                                Group {
                                    HStack {
                                        Text("Movies Suprised")
                                            .padding(.leading, 10)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .padding(.trailing, 10)
                                    }
                                }
                                .font(.title3)
                            }
                        }
                        .transition(.move(edge: .top))
                    }
                    Spacer()
                    if btn3 {
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                                    btn.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                                    btn1.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3).delay(0.15)) {
                                    btn2.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    btn3.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    background.toggle()
                                }
                                withAnimation(.easeInOut(duration: 0.6)){
                                    contains.toggle()
                                    isContact = "isRate"
                                }
                            } label: {
                                Group {
                                    HStack {
                                        Text("Movies Rated")
                                            .padding(.leading, 10)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .padding(.trailing, 10)
                                    }
                                }
                                .font(.title3)
                            }
                        }
                        .transition(.move(edge: .top))
                    }
                    Spacer()
                }
                .frame(width: isWidth,height: isWidth)
            } else {
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.6)){
                                background.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.6)){
                                contains.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                                btn3.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                                btn2.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(0.15)) {
                                btn1.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3)) {
                                btn.toggle()
                            }
                        } label: {
                            Group {
                                HStack {
                                    Text(isContact == "isLike" ? "Movies Liked" : isContact == "isSuprise" ? "Movies Suprised" : "Movies Rated")
                                        .padding(.leading, 10)
                                    Spacer()
                                    Image(systemName: "slider.horizontal.3")
                                        .padding(.trailing, 10)
                                }
                                .frame(width: isWidth)
                            }
                            .font(.title3)
                        }
                    }
                    .matchedGeometryEffect(id: "text", in: namespace)
            }
        }
    }
}

struct FilterContact_Previews: PreviewProvider {
    static var previews: some View {
        FilterContact(isWidth: 190, isContact: .constant("isLike"))
    }
}
