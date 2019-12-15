//
//  MovieController.swift
//  App
//
//  Created by Yusuf ali cezik on 15.12.2019.
//

import Vapor
import FluentSQLite

struct MovieController:RouteCollection{
    func boot(router: Router) throws {
        router.get("api/movies", use: index)
        router.post(Movie.self, at:"api/movie", use: create)
        router.delete("api/movie", Movie.parameter, use: delete)
        router.get("/main", use: show)
        router.get("movies", use: getAll)
    }
    
    func index(req:Request)->Future<[Movie]>{
        return Movie.query(on: req).all()
    }
    
    func create(req:Request, movie:Movie)->Future<Movie>{
        return movie.save(on: req)
    }
    
    func delete(req:Request) throws -> Future<Movie>{
        return try req.parameters.next(Movie.self).delete(on: req)
    }
    
    func show(req:Request) throws -> Future<View>{
        let context = WelcomeContext(title: "Vapor ile server side", number: 3)
        return try req.view().render("hello", context) //like params
    }
    
    func getAll(req:Request) throws -> Future<View>{
        return Movie.query(on: req).all().flatMap(to: View.self, { movies in
            let context = MovieContext(movies: movies)
            return try req.view().render("index", context)
        })
    }
}

struct WelcomeContext:Encodable{
    var title:String
    var number:Int
}
struct MovieContext:Encodable{
    var movies:[Movie]?
}
