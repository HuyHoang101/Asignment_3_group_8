//
//  ImageModel.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 21/09/2023.
//

import Foundation
import UIKit
import FirebaseStorage


class ImageModel: ObservableObject {
    @Published var img = UIImage()
    
    func retrievedImage(url : String?) {
        let storageRef = Storage.storage().reference()
        if url != nil {
            let fileRef = storageRef.child(url!)
            
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                
                if error == nil && data != nil {
                    
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            print("success")
                            self.img = image
                        }
                    }
                }
            }
        }
    }
}
