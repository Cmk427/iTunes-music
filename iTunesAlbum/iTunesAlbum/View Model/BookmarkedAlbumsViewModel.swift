//
//  BookmarkedAlbumsViewModel.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import Foundation

class BookmarkedAlbumsViewModel {
    
    var bookmarkedDB: BookmarkedDB
    var bookmarkedAlbums = [Album]()
    
    var count: Int {
        return bookmarkedAlbums.count
    }
    
    init(bookmarkedDB: BookmarkedDB) {
        self.bookmarkedDB = bookmarkedDB
        self.bookmarkedAlbums = bookmarkedDB.getAllAlbumNames()
    }
    
    func fetchAlbums(completion: @escaping () -> Void) {
        self.bookmarkedAlbums = bookmarkedDB.getAllAlbumNames()
    }
    
    func removeBookmark(at index: Int) {
        let albumName = bookmarkedAlbums[index].collectionName
        bookmarkedDB.removeAlbum(albumName: albumName)
        self.bookmarkedAlbums.remove(at: index)
    }
    
}
