//
//  UIImage+Extensions.swift
//  Pact
//
//  Created by Jake Goodman on 6/3/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

extension UIImage {
    func compressed() -> UIImage {
        
        let actualHeight:CGFloat = size.height
        let actualWidth:CGFloat = size.width
        let imgRatio:CGFloat = actualWidth/actualHeight
        let maxWidth:CGFloat = 600
        let resizedHeight:CGFloat = maxWidth/imgRatio
        let compressionQuality:CGFloat = 0.5
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:Data = UIImageJPEGRepresentation(img, compressionQuality)!
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData)!
    }
}
