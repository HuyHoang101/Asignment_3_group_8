//
//  LoadingAnimation.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 14/09/2023.
//

import SwiftUI

struct LoadingAnimation: View {
    @AppStorage("isDark") var isDark = false // synchronize user's setting of light/dark mode
    @State var isAnimate1 = false
    @State var isAnimate2 = false
    @State var isAnimate3 = false
    @State var isAnimate4 = false
    @State var isSeconds = false
    // counting timer
    @State var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var status: Bool // success or error
    
    var body: some View {

        Group {
            if !isSeconds {
                // MARK: - THE GREEN LOADING SCREEN
                VStack {
                    HStack {
                        Circle()
                            .fill(!isDark ? Color.green : Color.white)
                            .frame(width: 20)
                            .scaleEffect(isAnimate1 ? 1.0 : 0.6)
                            .onAppear() {
                                withAnimation(.easeInOut(duration: 0.5).repeatForever()){
                                    isAnimate1.toggle()
                                }
                            }
                            .padding(.horizontal, 3)
                        Circle()
                            .fill(!isDark ? Color.green : Color.white)
                            .frame(width: 20)
                            .scaleEffect(isAnimate2 ? 1.0 : 0.6)
                            .onAppear() {
                                withAnimation(.easeInOut(duration: 0.5).repeatForever().delay(0.25)){
                                    isAnimate2.toggle()
                                }
                            }
                            .padding(.horizontal, 3)
                        Circle()
                            .fill(!isDark ? Color.green : Color.white)
                            .frame(width: 20)
                            .scaleEffect(isAnimate3 ? 1.0 : 0.6)
                            .onAppear() {
                                withAnimation(.easeInOut(duration: 0.5).repeatForever().delay(0.5)){
                                    isAnimate3.toggle()
                                }
                            }
                            .padding(.horizontal, 3)
                    }
                    Text("Loading...")
                        .bold()
                        .padding(.top, 10)
                        .foregroundColor(!isDark ? Color.green : Color.white)
                        .offset(x: 5)
                }
            } else {
                if status {
                    // MARK: - SUCCESS MESSAGE
                    VStack {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundColor(!isDark ? Color.green : Color.white)
                        Text("Success!!")
                            .bold()
                            .padding(.top, 10)
                            .foregroundColor(!isDark ? Color.green : Color.white)
                    }
                    .scaleEffect(isAnimate4 ? 1.0 : 0.6)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 0.5)){
                            isAnimate4.toggle()
                        }
                    }
                } else {
                    // MARK: - ERROR MESSAGE
                    VStack {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundColor(!isDark ? Color.red : Color.white)
                        Text("Error!!")
                            .bold()
                            .padding(.top, 10)
                            .foregroundColor(!isDark ? Color.red : Color.white)
                    }
                    .scaleEffect(isAnimate4 ? 1.0 : 0.6)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 0.5)){
                            isAnimate4.toggle()
                        }
                    }
                }
            }
        }
        // the loading screen appears 3 seconds, after that display success/error message
        .onReceive(timer) { time in
            counter += 1
            if counter == 2 {
                isSeconds = true
            }
        }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation(status: true)
    }
}
