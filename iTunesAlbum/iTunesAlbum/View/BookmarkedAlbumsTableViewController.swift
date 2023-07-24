//
//  BookmarkedAlbumsTableViewController.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import UIKit

class BookmarkedAlbumsTableViewController: UITableViewController {
    let viewModel = BookmarkedAlbumsViewModel(bookmarkedDB: BookmarkedDB())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "AlbumTableViewCell")
        self.title = "Bookmarked Albums"
        viewModel.fetchAlbums(){
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell 
        
        let album = viewModel.bookmarkedAlbums
        cell.setAlbumData(album:album[indexPath.row])
        cell.bookmarkButton.isSelected = true
        
        cell.onBookmarkButtonTapped = { [weak self] in
            self?.viewModel.removeBookmark(at: indexPath.row)
            self?.tableView.reloadData()
        }
        
        return cell
    }
}
