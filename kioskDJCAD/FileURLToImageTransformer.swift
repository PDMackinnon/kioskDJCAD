//
//  FileURLToImageTransformer.swift
//  objController
//
//  Created by Paul Mackinnon on 16/02/2023.
//

import Cocoa

class FileURLToImageTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSImage.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override func transformedValue(_ value: Any?) -> Any? {
//        print(value!)
        guard let urlString = value as? String else {
            print("not string ??????")
            return nil }
        print("transforming /(url)")
        return NSImage(contentsOfFile: urlString)
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let image = value as? NSImage,
              let imageData = image.tiffRepresentation
        else { return nil }
        let imageFileTypes = NSBitmapImageRep.imageTypes
        let panel = NSSavePanel()
        panel.allowedFileTypes = [imageFileTypes.first!]
        if panel.runModal() == .OK, let url = panel.url {
            do {
                try imageData.write(to: url)
                return url
            } catch {
                print("Failed to write image data to file: \(error)")
                return nil
            }
        }
        return nil
    }
}
