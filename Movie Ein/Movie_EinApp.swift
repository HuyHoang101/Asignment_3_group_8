//
//  Movie_EinApp.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 08/09/2023.
//

import SwiftUI
import Firebase

@main
struct Movie_EinApp: App {
    init() {
        FirebaseApp.configure()
    }
    @AppStorage("isDark") var isDark = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
}
