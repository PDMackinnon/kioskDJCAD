//
//  LaunchItem+CoreDataProperties.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 27/03/2025.
//
//

import Foundation
import CoreData


extension LaunchItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LaunchItem> {
        return NSFetchRequest<LaunchItem>(entityName: "LaunchItem")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var external: Bool
    @NSManaged public var imagePath: String?
    @NSManaged public var url: String?

}

extension LaunchItem : Identifiable {

}
