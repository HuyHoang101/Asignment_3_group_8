//
//  SplashScreen.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 14/09/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var status1 = false
    @State private var status2 = false
    @State private var status3 = false
    @State private var status4 = false
    @State private var status5 = false
    @State private var status6 = false
    @State private var status7 = false
    @State private var status8 = false
    @State private var status9 = false
    @State private var status10 = false
    @AppStorage("isDark") var isDark = false
    
    var body: some View {
        ZStack {
            BackgroundPage()
            HStack {
                Spacer()
                Group {
                    Text("M")
                        .opacity(status1 ? 1 : 0)
                        .offset(y: status2 ? 0 : -130)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3)){
                                status1.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.6).delay(0.2)){
                                status2.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(3.5)){
                                status1.toggle()
                            }
                        }
                    Text("o")
                        .offset(x: -6)
                        .opacity(status5 ? 1 : 0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(1.6)){
                                status5.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(3.4)){
                                status5.toggle()
                            }
                        }
                    Text("v")
                        .offset(x: -12)
                        .opacity(status6 ? 1 : 0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(1.7)){
                                status6.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(3.3)){
                                status6.toggle()
                            }
                        }
                    Text("i")
                        .offset(x: -18)
                        .opacity(status7 ? 1 : 0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(1.8)){
                                status7.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(3.2)){
                                status7.toggle()
                            }
                        }
                    Text("e")
                        .offset(x: -24)
                        .opacity(status8 ? 1 : 0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(1.9)){
                                status8.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(3.1)){
                                status8.toggle()
                            }
                        }
                    Text("E")
                        .offset(x: -24)
                        .opacity(status3 ? 1 : 0)
                        .offset(y: status4 ? 0 : -130)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(0.45)){
                                status3.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.6).delay(0.65)){
                                status4.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(3.0)){
                                status3.toggle()
                            }
                        }
                    Text("i")
                        .offset(x: -30)
                        .opacity(status9 ? 1 : 0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(2.0)){
                                status9.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(2.9)){
                                status9.toggle()
                            }
                        }
                    Text("n")
                        .offset(x: -36)
                        .opacity(status10 ? 1 : 0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 0.3).delay(2.1)){
                                status10.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(2.8)){
                                status10.toggle()
                            }
                        }
                }
                .offset(x: 10)
                .font(Font.custom("Kalam-Bold", size: 44))
                .foregroundColor(!isDark ? .black : .white)
                
                Spacer()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
