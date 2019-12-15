//
//  AddImageURLMovie.swift
//  App
//
//  Created by Yusuf ali cezik on 15.12.2019.
//

import FluentSQLite
import Vapor

struct AddImageURLMovie:SQLiteMigration{
    static func prepare(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        return SQLiteDatabase.update(Movie.self, on: conn) { (builder) in
            let defaultValueConstraint = SQLiteColumnConstraint.default(.literal(0))
            builder.field(for: \.imageURL, type: .text, defaultValueConstraint )
        }
    }
    
    static func revert(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        return SQLiteDatabase.delete(Movie.self, on: conn)
    }
}
