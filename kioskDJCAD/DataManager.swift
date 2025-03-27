//
//  DataManager.swift
//  kioskDJCAD
//
//  Created by admin on 17/03/2025.
//

import Cocoa
import CoreData



class DataManager {
    
    private let persistentContainer:NSPersistentContainer
//    private var managedObjectContext:NSManagedObjectContext
//    private var persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    static let shared = DataManager()
    
    
    private init() {

        self.persistentContainer = NSPersistentContainer(name: "kioskModel")
        self.persistentContainer.loadPersistentStores(completionHandler:   {(storeDescription, error) in
            
            if let error = error {
                fatalError("failed to init core data stack: \(error)")
                }
            }) //end competion handler
        
        

    } // end init
    
    
    @objc dynamic var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        return persistentContainer.persistentStoreCoordinator
    }
    
    @objc dynamic var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Save context if there are any changes
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Context saved successfully!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error saving context \(nserror), \(nserror.userInfo)")
            }
        }
    }// end save context
    
    
    
    
}//end class
