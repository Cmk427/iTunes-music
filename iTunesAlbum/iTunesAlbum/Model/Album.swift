//
//  Album.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

struct Album: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
}

struct Response: Codable {
    let results: [Album]
}
