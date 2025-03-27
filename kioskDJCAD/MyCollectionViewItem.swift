//
//  MyCollectionViewItem.swift
//  collectionVtest
//
//  Created by Paul MacKinnon (Staff) on 11/02/2025.
//

import Cocoa



protocol MyCollectionViewItemDelegate: AnyObject {
    func collectionViewItem(_ item: MyCollectionViewItem, didRequestInternalLaunchWith url:URL)
} //end protocol requirements


class MyCollectionViewItem: NSCollectionViewItem {

    
    @IBOutlet weak var launchButton: NSButton!
    
    @IBOutlet weak var testV: NSView!
    
    weak var delegate: MyCollectionViewItemDelegate?
    var item: LaunchItem?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
//        print("my button: \(String(describing: launchButton))")
//        print("myView: \(String(describing: testV))")
    }
    
    func configure(with item: LaunchItem ) {
        
        let placeholderImage = NSImage(named: "cat400x400") // Ensure this exists in your assets

        if let imagePath = item.imagePath, !imagePath.isEmpty,
           let image = NSImage(contentsOfFile: imagePath) {
            self.launchButton.image = image
        } else {
            self.launchButton.image = placeholderImage
        }

        self.launchButton.title = item.displayName ?? "Something"
        
        self.item = item
        
        
        
    }// end configure item
    
    
    @IBAction func lauchButtonClicked(_ sender:Any) {
        print("clicked")
        
        guard let urlString = item?.url, let url = URL(string: urlString) else {
            print("invalid url string")
            return
        }
        
        if item?.external == true {
            NSWorkspace.shared.open(url);

        } else {
            delegate?.collectionViewItem(self, didRequestInternalLaunchWith: url)
        }
        

        
        
        
    }
    
}// end class
