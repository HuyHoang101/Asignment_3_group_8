//
//  MovieModel.swift
//  Movie Ein
//
//  Created by Nguyen Huy Hoang on 16/09/2023.
//

import Foundation
import FirebaseFirestore

class MovieModel: ObservableObject {
    @Published var movies = [Movie]()
    
    private var db = Firestore.firestore()
    
    init() {
        getAllMovieData()
    }
    
    func getAllMovieData() {
        
        db.collection("Movies").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.movies = documents.map { (queryDocumentSnapshot) -> Movie in
                let data = queryDocumentSnapshot.data()
             
                let imageUrl = data["imageUrl"] as? String ?? ""
                let trailerUrl = data["trailerUrl"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let age = data["age"] as? Int ?? 1
                let published = data["published_date"] as? Date ?? Date.now
                let category = data["category"] as? [String] ?? [String]()
                let owner = data["owner"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let rating = data["rating"] as? [Int] ?? [Int]()
                let director = data["director"] as? String ?? ""
                let actors = data["actors"] as? [String] ?? [String]()
                
                return Movie(ImageUrl: imageUrl, TrailerUrl: trailerUrl, name: name, age: age, published: published, category: category, owner: owner, description: description, rating: rating, director: director, actors: actors, documentID: queryDocumentSnapshot.documentID)
            }
        }
    }
    
    func addMovie(imageUrl: String, trailerUrl: String, name: String, age: Int, published: Date, category: [String], owner: String, description: String, director: String, actors: [String]){
        var rating = [Int]()
        rating.append(0)
        db.collection("Movies").addDocument(data: ["imageUrl": imageUrl, "trailerUrl": trailerUrl, "name": name, "age": age, "published_date": published, "category": category, "owner": owner, "description": description, "rating": rating, "director": director, "actors": actors])
    }
    
    func deleteMovie(documentID: String) {
        db.collection("Movies").document(documentID).delete { (error) in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func get5Movie() -> [Movie] {
        var movie = [Movie]()
        if movies.count >= 5 {
            for i in 0...4 {
                movie.append(movies[i])
            }
        }
        return movie
    }
    
    func getCategoryMovie(category: String) -> [Movie] {
        var movie = [Movie]()
        for mov in movies {
            for cate in mov.category! {
                if cate == category {
                    movie.append(mov)
                    break
                }
            }
        }
        
        return movie
    }
    
    func addRatingByMovieImagelink(url: String, rating: Int) {
        db.collection("Movies").whereField("imageUrl", isEqualTo: url).getDocuments { (snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            let movie = self.movies.filter({ $0.ImageUrl == url })
            
            for i in snap!.documents {
                DispatchQueue.main.async {
                    if movie.count > 0 {
                        var rates = movie[0].rating ?? [Int]()
                        rates.append(rating)
                        i.reference.updateData(["rating": rates])
                    }
                }
            }
        }
    }
    
    func calculateRatingbyDocumentID(documentID: String) -> Double {
        var result = 0.0
        
        let movie = movies.filter({ $0.documentID == documentID})
        
        if movie.count > 0 {
            for i in movie[0].rating! {
                    result += Double(i)
            }
            
            if result != 0 {
                result = result / Double(movie[0].rating!.count - 1)
            }
        }
    
        return result
    }
    
    
    func getMoviesByDocumentIDArray(documentID: [String]) -> [Movie] {
        var myMovie = [Movie]()
        for doc in documentID {
            for movie in movies {
                if doc == movie.documentID {
                    myMovie.append(movie)
                }
            }
        }
        
        return myMovie
    }
    
    func getPriogityCategory(movie: Movie) -> String {
        var cate = String()
        for i in movie.category! {
            if i == "Horror" {
                cate = "Horror"
                return cate
            }
        }
        for i in movie.category! {
            if i == "Anime/Family" {
                cate = "Anime/Family"
                return cate
            }
        }
        for i in movie.category! {
            if i == "Romance" {
                cate = "Romance"
                return cate
            }
        }
        for i in movie.category! {
            if i == "Action" {
                cate = "Action"
                return cate
            }
        }
        for i in movie.category! {
            cate = i
            break
        }
        return cate
    }
    
    func updateMovieDatabyTrailersLink(link: String, imageUrl: String, trailerUrl: String, name: String, age: Int, published: Date, category: [String], description: String, director: String, actors: [String]) {
        db.collection("Movies").whereField("trailerUrl", isEqualTo: link).getDocuments { (snap, err) in
            
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                
                if imageUrl != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["imageUrl": imageUrl])
                    }
                }
                
                if trailerUrl != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["trailerUrl": trailerUrl])
                    }
                }
                
                if name != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["name": name])
                    }
                }
                
                DispatchQueue.main.async {
                    i.reference.updateData(["age": age])
                }
                
                DispatchQueue.main.async {
                    i.reference.updateData(["published_date": published])
                }
                
                DispatchQueue.main.async {
                    i.reference.updateData(["category": category])
                }
                
                if description != "" {
                    DispatchQueue.main.async {
                        i.reference.updateData(["description": description])
                    }
                }
                
                
                DispatchQueue.main.async {
                    i.reference.updateData(["director": director])
                }
                
                
                DispatchQueue.main.async {
                    i.reference.updateData(["actors": actors])
                }
                
            }
        }
    }
    
    func getMovieByDocumentID(doc: String) -> Movie {
        var mov = Movie()
        
        for movie in movies {
            if doc == movie.documentID {
                mov = movie
                break
            }
        }
        
        return mov
    }
}
