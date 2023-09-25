//
//  AccountModel.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 09/09/2023.
//

import Foundation
import FirebaseFirestore

class AccountModel: ObservableObject {
    @Published var accounts = [Account]()
    
    private var db = Firestore.firestore()
    
    init() {
        getAllAccountData()
    }
    
    func getAllAccountData() {
        
        //Retrieve the "Accounts" document
        db.collection("Accounts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "userName" field inside each movie document
            self.accounts = documents.map { (queryDocumentSnapshot) -> Account in
                let data = queryDocumentSnapshot.data()
                
                let userName = data["userName"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let age = data["age"] as? String ?? ""
                let birth = data["birth"] as? String ?? ""
                let sex = data["sex"] as? String ?? ""
                let job = data["job"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let url = data["url"] as? String ?? ""
                return Account(userName: userName, name: name, age: age, birth: birth, sex: sex, job: job, address: address, url: url, documentID: queryDocumentSnapshot.documentID)
            }
        }
    }
    
    func getAccountByUserName(UserName: String) -> Account {
        var acc = Account()
        for i in accounts {
            if UserName == i.userName {
                acc = i
            }
        }
        return acc
    }
    
    func addAccount(userName: String) {
        //add a new document of a Account userName in the "Accounts" collection
        db.collection("Accounts").addDocument(data: ["userName": userName, "name": "", "age": "", "birth": "", "sex": "", "job": "", "address": "", "url": ""])
    }
    
    func readName(account: Account) -> String {
        var user = ""
        if account.name != nil {
            user = account.name!
        }
        return user
    }
    
}
