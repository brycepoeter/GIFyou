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
    
    /*
     This class is where the gif saving and extracting logic is kept. GIFs are saved
     to /Documents and retrieved from same place.
     */
    
    static let sharedInstance = GifFactory()
        
    private init() {}
    
    // Takes in an array of images from a ColorCell and a file name and saves the images
    // in gif format under the filename specified
    // https://stackoverflow.com/questions/39706401/generate-and-export-an-animated-gif-via-swift-3-0
    func saveGif(photos: [UIImage], filename: String) -> Bool {
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending(filename)
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 100]]
        let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: 0.5]]
        let cfURL = URL(fileURLWithPath: path) as CFURL
        if let destination = CGImageDestinationCreateWithURL(cfURL, UTType.gif.description as CFString, photos.count, nil) {
                CGImageDestinationSetProperties(destination, fileProperties as CFDictionary?)
                for photo in photos {
                    CGImageDestinationAddImage(destination, photo.cgImage!, gifProperties as CFDictionary?)
                }
                print("GifFactory succesfully saved GIF at \(cfURL)")
                return CGImageDestinationFinalize(destination)
            }
        return false
    }
    
    // Takes in a frame and a resourceName, finds the gif at the resource name,
    // turns it into a UIImageView, and places it in the frame. Way to display saved Gifs
    // https://stackoverflow.com/questions/27919620/how-to-load-gif-image-in-swift
    func showGif(frame: CGRect, resourceName: String) -> UIImageView? {
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending(resourceName)
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url), let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            print("couldnt get gifdata")
            return nil }
        print("GifFactory succesfully retrieved GIF at \(url)")
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0..<imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}
