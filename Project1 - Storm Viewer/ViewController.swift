//
//  ViewController.swift
//  Project1 - Storm Viewer
//
//  Created by John Kim on 1/15/22.
//

import UIKit

// Designing our interface

class ViewController: UICollectionViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        
        // Large titles
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // UIActivityViewController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Listing Images with FileManager
        
        DispatchQueue.global(qos: .userInitiated).async {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    // this is a picture to load!
                    self.pictures.append(item)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        
        pictures.sort()
        print(pictures)
    }
    
    // MARK: - UICollectionView data source methods
    
    // Showing lots of rows
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // Dequeuing cells
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//        cell.textLabel?.text = pictures[indexPath.row]
//        return cell
//    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCell else {
            fatalError("Unable to dequeue ImageCell.")
        }
        let picture = pictures[indexPath.item]
        cell.imageName.text! = picture
        cell.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 3
        return cell
    }
    
    // Loading images with UIImage
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 1. Load the "Detail" view controller and typecast it to be DetailViewController
//        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            // 2. Set its selectedImage property
//            detailViewController.selectedImage = pictures[indexPath.row]
//            detailViewController.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
//            // 3. Push it onto the navigation controller
//            navigationController?.pushViewController(detailViewController, animated: true)
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2. Set its selectedImage property
            detailViewController.selectedImage = pictures[indexPath.item]
            detailViewController.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
            // 3. Push it onto the navigation controller
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["You should use this app"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

