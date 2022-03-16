//
//  GifFactory.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/15/22.
//

import Foundation
import UIKit
import ImageIO
import MobileCoreServices
import UniformTypeIdentifiers

class GifFactory {
    
    static let sharedInstance = GifFactory()
        
    private init() {

    }
    
    // https://stackoverflow.com/questions/39706401/generate-and-export-an-animated-gif-via-swift-3-0
    func generateGif(photos: [UIImage], filename: String) -> Bool {
        
        // OH Notes: Seems like for whatever reason the photo not going to cgImage is messing it up
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending(filename)
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]
        let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: 0.125]]
        let cfURL = URL(fileURLWithPath: path) as CFURL
        if let destination = CGImageDestinationCreateWithURL(cfURL, UTType.gif.description as CFString, photos.count, nil) {
                CGImageDestinationSetProperties(destination, fileProperties as CFDictionary?)
                for photo in photos {
                    CGImageDestinationAddImage(destination, photo.cgImage!, gifProperties as CFDictionary?)
                }
                return CGImageDestinationFinalize(destination)
            }
        return false
    }
    
}
