//
//  AlbumListViewModel.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import Foundation

class AlbumListViewModel {
    var albums: [Album] = []
    var bookmarkedDB = BookmarkedDB()
    
    var count: Int {
        return albums.count
    }
    
    func album(at index: Int) -> Album {
        return albums[index]
    }
    
    func fetchAlbums(completion: @escaping () -> Void) {
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&entity=album"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(Response.self, from: data) {
                self.albums = response.results
                completion()
            }else{
                print("[Fetching] Error when fetching album: \(String(describing: error))")
            }
            
        }.resume()
    }
    
    func bookmarkAlbum(at index: Int) {
        let albumName = albums[index].collectionName
        let artistName = albums[index].artistName
        let imageName = albums[index].artworkUrl100
        
        if !(checkAlbumExist(at: index)){
            bookmarkedDB.addAlbum(collectionName: albumName, artist: artistName, artworkUrl100: imageName)
        }else{
            bookmarkedDB.removeAlbum(albumName: albumName)
        }
    }
    
    func checkAlbumExist(at index: Int) -> Bool {
        let albumToBookmark = albums[index].collectionName
        return bookmarkedDB.checkAlbumExists(albumName: albumToBookmark)
    }
    
}
