//
//  VideoUploader.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 15/09/2023.
//

import Foundation
import FirebaseStorage

struct VideoUploader {
    
    static func uploadVideo(withData videoData: Data) async throws -> String? {
        let filename = NSUUID().uuidString
        
        let ref = Storage.storage().reference().child("/trailers/\(filename)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"
        
        do {
            let _ = try await ref.putDataAsync(videoData, metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            return nil
        }
    }
    
    static func getLinkForVideo(link: String) -> StorageReference {
        Storage.storage().reference(withPath: link)
    }
}
