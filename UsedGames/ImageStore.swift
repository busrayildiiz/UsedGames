//
//  ImageStore.swift
//  UsedGames
//
//  Created by MacBook Pro on 5.11.2023.
//

import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image:UIImage, forkey key: String){
        return cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forkey key: String) -> UIImage?{
        return cache.object(forKey: key as NSString)
    }
    
    func delete(forkey key : String){
        cache.removeObject(forKey: key as NSString)
    }
}
