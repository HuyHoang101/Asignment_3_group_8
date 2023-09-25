//
//  ContentView.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDark") var isDark = false
    @State private var status = true
    @State private var isPage = 1
    @State private var status1 = false
    @State private var isExit = false
    @State private var btn1 = false
    @State private var btn2 = false
    @State private var tap = false
    
    var body: some View {
        if status {
            SplashScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
                        // your code here
                        status.toggle()
                    }
                }
        } else {
            ZStack {
                if isPage == 3 {
                    AccountDetailView(btn: $btn1)
                        .transition(.move(edge: .trailing))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                // your code here
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    isExit = false
                                }
                            }
                        }
                } else if isPage == 2 {
                    MyMovie(status1: $btn2)
                        .transition(.move(edge: .trailing))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                // your code here
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    isExit = false
                                }
                            }
                        }
                } else {
                    MyHomeView(isUsing: $tap)
                        .transition(.move(edge: .trailing))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                // your code here
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    isExit = false
                                }
                            }
                        }
                }
                VStack {
                    Spacer()
                    
                    ButtonBarPage(isPage: $isPage, isExit: $isExit)
                        .disabled(status1)
                        .opacity(status1 ? 0.4 : 1)
                        .onChange(of: btn1) { _ in
                            if btn1 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status1 = true
                                    isExit = false
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status1 = false
                                    isExit = false
                                }
                            }
                        }
                        .onChange(of: btn2) { _ in
                            if btn2 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status1 = true
                                    isExit = false
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status1 = false
                                    isExit = false
                                }
                            }
                        }
                        .onChange(of: tap) { _ in
                            if tap {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status1 = true
                                    isExit = false
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status1 = false
                                    isExit = false
                                }
                            }
                        }
                }
            }
            //.environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
