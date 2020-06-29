//
//  UIImageView+Extensions.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 27.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode) {
        contentMode = mode
        if let imageFromCache = Cache.imageCache.object(forKey: (url.absoluteString as AnyObject) as! NSString) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async() {
                if let imageData = data {
                    let imageToCache = UIImage(data: imageData)
                    self.image = imageToCache
                    Cache.imageCache.setObject(imageToCache!, forKey: (url.absoluteString as AnyObject) as! NSString)
                }
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}
