//
//  AlbumListViewController.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import UIKit

class AlbumListViewController: UITableViewController {
    
    let viewModel = AlbumListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "AlbumTableViewCell")
        self.title = "Albums"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.goBookmarkedAlbums(tapGestureRecognizer:)))
        viewModel.fetchAlbums {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @objc func goBookmarkedAlbums(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController?.pushViewController(BookmarkedAlbumsTableViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        
        let album = viewModel.album(at: indexPath.row)
        cell.setAlbumData(album:album)
        cell.bookmarkButton.isSelected = self.viewModel.checkAlbumExist(at: indexPath.row)
        
        cell.onBookmarkButtonTapped = { [weak self] in
            self?.viewModel.bookmarkAlbum(at: indexPath.row)
        }
        
        return cell
    }
}
