//
//  AlbumTableViewCell.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var onBookmarkButtonTapped: (() -> Void)?
    var apiService = APIService()
    
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var bookmarkButton: UIButton!
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        onBookmarkButtonTapped?()
    }
    
    func setAlbumData(album: Album) {
        albumName.text = album.collectionName
        artistName.text = album.artistName
        apiService.setImage(url: album.artworkUrl100) { [weak self] image in
            DispatchQueue.main.async {
                self?.albumImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkButton.isEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
