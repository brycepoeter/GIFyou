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
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending(filename)
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]
        let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: 0.5]]
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
    
    // https://stackoverflow.com/questions/27919620/how-to-load-gif-image-in-swift
    func showGif(frame: CGRect, resourceName: String) -> UIImageView? {
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending(resourceName)
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url), let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            print("couldnt get gifdata")
            return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0..<imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        gifImageView.animationDuration = 3
        gifImageView.startAnimating()
        return gifImageView
    }
    
    public func returnImageFromGifFile(filename: String) -> UIImage? {
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsDirectoryPath.appending(filename)
        let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    return image
//                    PHPhotoLibrary.shared().performChanges({
//                        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
//                        }, completionHandler: {completed, error in
//                            if error != nil {
//                                print("error")
//                            } else if completed {
//                                print("completed")
//                            } else {
//                                print("not completed")
//                            }
//                    })
                }

            } catch let error {
                print(error)
                
            }
        return nil
        }
    
    
}
