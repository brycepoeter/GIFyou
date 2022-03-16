//
//  View.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/15/22.
//

import Foundation
import UIKit

extension UIView {
    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let img = renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        return img
    }
    
    func saveAsJpeg(fileName: String) {
        if let data = toImage().jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: filename)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
//    var asJpeg: Data? {
////        return toImage().jpegData(compressionQuality: 1.0)
//    }
}
