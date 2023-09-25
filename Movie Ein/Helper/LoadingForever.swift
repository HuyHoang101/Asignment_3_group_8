//
//  LoadingForever.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 15/09/2023.
//

import SwiftUI

struct LoadingForever: View {
    @AppStorage("isDark") var isDark = false
    @State var isAnimate1 = false
    @State var isAnimate2 = false
    @State var isAnimate3 = false
    @State var isAnimate4 = false
    
    var body: some View {
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
    }
}

struct LoadingForever_Previews: PreviewProvider {
    static var previews: some View {
        LoadingForever()
    }
}
