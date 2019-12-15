import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
//    router.get { req in
//        return "It works!"
//    }
//
//    // Basic "Hello, world!" example
//    router.get("hello") { req in
//        return "Hello, world!"
//    }
//
//    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
//
//
//    router.post(Movie.self, at:"api/movie") { (request, movie)-> Future<Movie> in
//        return movie.save(on:request)
//    }
//
//    router.get("api/movies") { req->Future<[Movie]> in
//        return Movie.query(on: req).all()
//    }
//
//    router.delete("api/movie", Movie.parameter) { req -> Future<Movie> in
//        return try req.parameters.next(Movie.self).delete(on: req)
//    }
    
    let movieController = MovieController()
    try router.register(collection: movieController) //routera save
    
//    router.get("hello"){ req->Future<View> in
//        return try req.view().render("hello", ["name":"Yusuf"])
//    }
}
