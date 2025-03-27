//
//  AndTransformer.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 23/03/2023.
//

import Cocoa

class AndTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSNumber.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return false
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let boolArray = value as? [Bool] else { return nil }
        return boolArray.reduce(true) { $0 && $1 }
    }
}
