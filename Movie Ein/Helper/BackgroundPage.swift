//
//  BackgroundPage.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 08/09/2023.
//

import SwiftUI

struct BackgroundPage: View {
    @AppStorage("isDark") var isDark = false
    var body: some View {
        let col1 = isDark ? "Dark" : "WhiteYellow1"
        let col2 = isDark ? "Dark" : "WhiteYellow2"
        let col3 = isDark ? "Dark" : "WhiteYellow3"
        ZStack{
            LinearGradient(colors: [Color(col1), Color(col2), Color(col3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BackgroundPage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundPage()
    }
}
