//
//  imageTransform.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 13/05/2022.
//

import Cocoa

@objc(ImageTransform) class ImageTransform: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
            return NSString.self
        }
        
        override class func allowsReverseTransformation() -> Bool {
            return false
        }
        
        override func transformedValue(_ value: Any?) -> Any? {
            
            print("value to transform is \(String(describing: value))");
            
            return (value as AnyObject).className
        }

}


extension ImageTransform {
    static let imageTransformerName = NSValueTransformerName(rawValue: "ImageTransform")
}

//ValueTransformer.setValueTransformer(ImageTransform(), forName: NSValueTransformerName.imageTransformerName)


