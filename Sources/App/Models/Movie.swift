//
//  Movie.swift
//  App
//
//  Created by Yusuf ali cezik on 15.12.2019.
//

import Vapor
import FluentSQLite

final class Movie: Content{
    var id:Int?
    var title:String
    var year:Int
    var imageURL:String
    var description:String
    var detail:Detail
    
    init(title:String, year:Int, description:String, detail:Detail, imageURL:String){
        self.title = title
        self.year = year
        self.description = description
        self.detail = detail
        self.imageURL = imageURL
    }
}

final class Detail:Content{
    var genre : [String]
    var director:String
    
    init(genre:[String], director:String){
        self.genre = genre
        self.director = director
    }
}

extension Movie:SQLiteModel{
}
extension Movie:Migration{
}
extension Movie:Parameter{
    
}
