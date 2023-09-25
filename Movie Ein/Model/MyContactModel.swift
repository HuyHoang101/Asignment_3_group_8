//
//  MyContactModel.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 18/09/2023.
//

import Foundation
import Firebase

class MyContactModel: ObservableObject {
    @Published var contacts = [MyContact]()
    
    private var db = Firestore.firestore()
    
    init() {
        getAllContact()
    }
    
    func getAllContact() {
        db.collection("MyContacts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "userName" field inside each movie document
            self.contacts = documents.map { (queryDocumentSnapshot) -> MyContact in
                let data = queryDocumentSnapshot.data()
                
                let userName = data["userName"] as? String ?? ""
                let isLike = data["isLike"] as? [String] ?? [String]()
                let isSuprise = data["isSuprise"] as? [String] ?? [String]()
                let isRating = data["isRating"] as? [String] ?? [String]()
                return MyContact(userName: userName, isLike: isLike, isSuprise: isSuprise, isRating: isRating, documentID: queryDocumentSnapshot.documentID)
            }
        }
    }
    
    func addContact(userName: String) {
        var isLike = [String]()
        isLike.append(".")
        db.collection("MyContacts").addDocument(data: ["userName" : userName, "isLike" : isLike, "isSuprise" : isLike, "isRating" : isLike])
    }
    
    func addContactStatus(userName: String, movieID: String, status: String) {
        db.collection("MyContacts").whereField("userName", isEqualTo: userName).getDocuments { (snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            let contact = self.contacts.filter({ $0.userName == userName })
            
            if contact.count > 0 {
                for i in snap!.documents {
                    
                    if status == "isLike" {
                        var isLike = [String]()
                        for i in contact[0].isLike! {
                            if i != movieID {
                                isLike.append(i)
                            }
                        }
                        DispatchQueue.main.async {
                            if isLike.count == contact[0].isLike!.count {
                                isLike.append(movieID)
                                i.reference.updateData(["isLike": isLike])
                            }
                        }
                    }
                    
                    if status == "isSuprise" {
                        var isSuprise = contact[0].isSuprise ?? [String]()
//                        for i in contact[0].isSuprise! {
//                            if i != movieID {
//                                isSuprise.append(i)
//                            }
//                        }
                        DispatchQueue.main.async {
                            isSuprise.append(movieID)
                            i.reference.updateData(["isSuprise": isSuprise])
                        }
                    }
                    
                    if status == "isRating" {
                        var isRating = [String]()
                        
                        for i in contact[0].isRating! {
                            if i != movieID {
                                isRating.append(i)
                            }
                        }
                        DispatchQueue.main.async {
                            if isRating.count == contact[0].isRating!.count {
                                isRating.append(movieID)
                                i.reference.updateData(["isRating": isRating])
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkIsContacted(userName: String, movieID: String, isContact: String) -> Bool {
        let contact = contacts.filter({ $0.userName == userName })
        
        var status = false
        
        if isContact == "isLike" {
            for con in contact {
                for c in con.isLike! {
                    if c == movieID {
                        status = true
                    }
                }
            }
        }
        
        if isContact == "isSuprise" {
            for con in contact {
                for c in con.isSuprise! {
                    if c == movieID {
                        status = true
                    }
                }
            }
        }
        
        if isContact == "isRating" {
            for con in contact {
                for c in con.isRating! {
                    if c == movieID {
                        status = true
                    }
                }
            }
        }
        
        return status
    }
    
    func deleteContactStatus(userName: String, movieID: String, status: String) {
        db.collection("MyContacts").whereField("userName", isEqualTo: userName).getDocuments { (snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            let contact = self.contacts.filter({ $0.userName == userName })
            
            if contact.count > 0 {
                for i in snap!.documents {
                    
                    if status == "isLike" {
                        var isLike = [String]()
                        for i in contact[0].isLike! {
                            if i != movieID {
                                isLike.append(i)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            i.reference.updateData(["isLike": isLike])
                        }
                    }
                    
                    if status == "isSuprise" {
                        var isSuprise = [String]()
                        for i in contact[0].isSuprise! {
                            if i != movieID {
                                isSuprise.append(i)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            i.reference.updateData(["isSuprise": isSuprise])
                        }
                    }
                }
            }
        }
    }
}
