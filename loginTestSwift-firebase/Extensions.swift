//
//  Extensions.swift
//  loginTestSwift-firebase
//
//  Created by Ricardo Duarte Sampaio on 2017-05-06.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()//will be the cache to store the images downloaded

extension UIImageView{
    
    //This code is to avoid the app download constantly images and make the app heavy
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cachr for imagefirst
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage{
            self.image = cachedImage
            return
        }
        //otherwise start a new download image
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            //After a download error
            if error != nil{
                print(error!)
                return
            }
            
            //If download successful load the images simutanially into the cells
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
    
}
