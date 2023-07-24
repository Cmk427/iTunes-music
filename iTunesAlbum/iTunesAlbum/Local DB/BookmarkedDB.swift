//
//  BookmarkedDB.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import Foundation
import SQLite

class BookmarkedDB {
    private let db: Connection
    
    init() {
        let fileManager = FileManager.default
        let documentsDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let databaseURL = documentsDirectory.appendingPathComponent("BookmarkedDB.db")
        self.db = try! Connection(databaseURL.path)
        
        self.createTable()
    }
    
    private func createTable() {
        let albums = Table("Bookmarked_Albums")
        let id = Expression<Int>("id")
        let albumName = Expression<String>("collectionName")
        let artistName = Expression<String>("artistName")
        let imageName = Expression<String>("artworkUrl100")
        
        do {
            try self.db.run(albums.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(albumName, unique: false)
                table.column(artistName, unique: false)
                table.column(imageName, unique: false)
            })
            print("[BookmarkedDB] Success to create table")
        } catch {
            print("[BookmarkedDB] Failed to create table")
        }
    }
    
    func checkAlbumExists(albumName: String) -> Bool {
        let albums = Table("Bookmarked_Albums")
        let name = Expression<String>("collectionName")
        
        do {
            let count = try db.scalar(albums.filter(name == albumName).count)
            return count != 0
        } catch {
            print("[BookmarkedDB] Failed to check album existence: \(albumName)")
            return false
        }
    }
    
    func removeAlbum(albumName: String) {
        let albums = Table("Bookmarked_Albums")
        let name = Expression<String>("collectionName")
        
        let albumName = albums.filter(name == albumName)
        
        do {
            try db.run(albumName.delete())
            print("[BookmarkedDB] Successfully removed album: \(albumName)")
        } catch {
            print("[BookmarkedDB] Failed to remove album: \(albumName)")
        }
    }
    
    func getAllAlbumNames() -> [Album] {
        let albums = Table("Bookmarked_Albums")
        let albumName = Expression<String>("collectionName")
        let artistName = Expression<String>("artistName")
        let imageName = Expression<String>("artworkUrl100")
        
        do {
            let albumRows = try db.prepare(albums.select(albumName, artistName, imageName))
            return albumRows.map { row in
                Album(artistName: row[artistName], collectionName: row[albumName], artworkUrl100: row[imageName])
            }
        } catch {
            print("[BookmarkedDB] Failed to get album names: \(albumName)")
            return []
        }
    }
    
    func addAlbum(collectionName: String, artist: String, artworkUrl100: String) {
        let albums = Table("Bookmarked_Albums")
        let albumName = Expression<String>("collectionName")
        let artistName = Expression<String>("artistName")
        let imageName = Expression<String>("artworkUrl100")
        
        let insert = albums.insert(albumName <- collectionName, artistName <- artist, imageName <- artworkUrl100)
        
        do {
            let rowId = try db.run(insert)
            print("[BookmarkedDB] Successfully added album with ID: \(rowId),\(collectionName)")
        } catch {
            print("[BookmarkedDB] Failed to add album: \(collectionName)")
        }
    }
    
}
