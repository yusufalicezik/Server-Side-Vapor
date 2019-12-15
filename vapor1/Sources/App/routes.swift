import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("anasayfa", String.parameter) { req->String in
        //"hg \(req.parameters.values.first!.value)"
        let name = try req.parameters.next(String.self)
        return "hg \(name)"
    }
    
    //Group
    let allUsers = router.grouped("users/allUsers")
    allUsers.get("1") { req in
        return "yusufalicezik"
    }
    
    
    //localhost:8080/users?userid=10&username=yusufali
    router.get("users"){ req->String in
        let id = try req.query.get(Int.self, at: "userid")
        let username = try req.query.get(String.self, at: "username")
        return "userid = \(id) and username = \(username)"
    }
    
    
    //MARK:- Json
    final class Movie: Content{
        var title, type:String
        var duration:Int
        var movieDetail:MovieDetail
        
        init(title:String, type:String, duration:Int,movieDetail:MovieDetail){
            self.title = title
            self.type = type
            self.duration = duration
            self.movieDetail = movieDetail
        }
    }
    
    final class MovieDetail: Content{
        var director:String
        var scenarist:String
        
        init(director:String, scenarist:String){
            self.director = director
            self.scenarist = scenarist
        }
    }
    
//    router.get("movies"){ req->[Movie] in
//        let movies = [Movie(title: "Yüzüklerin Efendisi", type: "Fantastik", duration: 200), Movie(title: "Harry Potter", type: "Fantastik", duration: 220)]
//        return movies
//    }
    
    
    router.get("movies") { req->Future<[Movie]> in
        return getAllMovies(req: req)
    }
    
    func getAllMovies(req:Request)->Future<[Movie]>{
        return Future.flatMap(on: req) { () -> EventLoopFuture<[Movie]> in
            let movies = [Movie(title: "Yüzüklerin Efendisi", type: "Fantastik", duration: 200, movieDetail: MovieDetail(director: "Yusuf", scenarist: "Ali")), Movie(title: "Harry Potter", type: "Fantastik", duration: 220, movieDetail: MovieDetail(director: "Yusuf", scenarist: "Ali"))]
            return Future.map(on: req) { () -> [Movie] in
                return movies
            }
        }
    }
    
    //Post
    router.post(Movie.self, at: "create/movie") { (req, data) -> Future<Movie> in //Future asenkron
        return Future.map(on: req) { () -> Movie in
            return data
        }
    }
    
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
