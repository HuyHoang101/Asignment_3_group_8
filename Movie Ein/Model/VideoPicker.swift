//
//  VideoPicker.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 15/09/2023.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class VideoPicker: ObservableObject {
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await  uploadVideo() } }
    }
    
    
    
    func uploadVideo() async throws {
        guard let item = selectedItem else { return }
        
        guard let videoData = try await item.loadTransferable(type: Data.self) else { return }
        
        guard let videoUrl = try await VideoUploader.uploadVideo(withData: videoData) else { return }
        
        try await Firestore.firestore().collection("videos").document().setData(["videoUrl" : videoUrl])
    }
    
    func deleteSelectItem() {
        selectedItem = nil

    }
    
    
    func deleteVideoByLink(link: String) async throws {
        try await Storage.storage().reference(withPath: link).delete()
    }
}
