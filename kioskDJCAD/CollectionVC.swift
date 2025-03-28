//
//  CollectionVC.swift
//  kioskDJCAD
//
//  Created by Paul Mackinnon on 24/03/2025.
//

import Foundation
import Cocoa

class collectionVC: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout, MyCollectionViewItemDelegate, NSFetchedResultsControllerDelegate  {
    func collectionViewItem(_ item: MyCollectionViewItem, didRequestInternalLaunchWith url: URL) {
        performSegue(withIdentifier: "showWebView", sender: url)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        
//        let webSiteUrlString = userDefaults.string(forKey: webSiteUrlKeys[tag]) ?? "https://www.dundee.ac.uk";
        
        let dest = segue.destinationController as! webViewController03;

        if let url = sender as? URL {
            let webSiteUrlString = url.absoluteString
            let notSet = "Not Set"
            print("prepare for segue \(segue.identifier ?? notSet)");
            
//            let dest = segue.destinationController as! webViewController03;
            
            dest.destURLString = webSiteUrlString;
        }
        else {
            
            dest.destURLString = "https://www.dundee.ac.uk";
        }
    }// end prepare for segue
    
    
    @objc dynamic var context:NSManagedObjectContext {
        return  DataManager.shared.managedObjectContext
        
    }
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var arrayController: NSArrayController!
    
    
    var items:[LaunchItem] = []
    
    var fetchedResultsController:NSFetchedResultsController<LaunchItem>!
    
    
    func setupFetchedResultsController() {
        let request:NSFetchRequest<LaunchItem> = LaunchItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:"displayName",ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DataManager.shared.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
//            items = try context.fetch(request)
            try fetchedResultsController.performFetch()
//            collectionView.reloadData()
        } catch {
            print("failed to fetch items: \(error)")
            
        }//end catch
    } //end func fetch items
    
    func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)
        
        if let launchItem = fetchedResultsController.fetchedObjects?[indexPath.item] {
            (item as? MyCollectionViewItem)?.configure(with: launchItem)
            (item as? MyCollectionViewItem)?.delegate = self
        }
        
//        if let collectionViewItem = item as? MyCollectionViewItem {
//                collectionViewItem.configure(with: items[indexPath.item])
//            collectionViewItem.delegate = self
//
//            return collectionViewItem
//            }
        
            return item
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        
        // Create a flow layout instance
        let flowLayout = NSCollectionViewFlowLayout()
        
        // Configure the layout properties
        flowLayout.itemSize = NSSize(width: 400, height: 450) // Set the size of each item
        flowLayout.minimumInteritemSpacing = 10.0 // Set the minimum space between items in the same row
        flowLayout.minimumLineSpacing = 10.0 // Set the minimum space between rows
        flowLayout.sectionInset = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Set the inset for the section

        // Assign the flow layout to the collection view
        collectionView.collectionViewLayout = flowLayout
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = NSNib(nibNamed: "MyCollectionViewItem", bundle: nil)
        collectionView.register(nib, forItemWithIdentifier: NSUserInterfaceItemIdentifier("CollectionViewItem"))
        
        
        setupFetchedResultsController()
        
        
    }// end view did load
    
}
