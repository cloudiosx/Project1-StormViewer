//
//  ViewController.swift
//  Project1 - Storm Viewer
//
//  Created by John Kim on 1/15/22.
//

import UIKit

// Designing our interface

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        
        // Large titles
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Listing Images with FileManager
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    // Showing lots of rows
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // Dequeuing cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    // Loading images with UIImage
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. Load the "Detail" view controller and typecast it to be DetailViewController
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2. Set its selectedImage property
            detailViewController.selectedImage = pictures[indexPath.row]
            
            // 3. Push it onto the navigation controller
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

