//
//  Image+Extensions.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 7/2/23.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
