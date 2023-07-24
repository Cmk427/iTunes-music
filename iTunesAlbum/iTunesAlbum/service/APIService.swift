//
//  APIService.swift
//  iTunesAlbum
//
//  Created by Oscar Chan on 24/7/2023.
//

import Foundation
import UIKit

class APIService: NSObject{
    
    func setImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("No image data available")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
