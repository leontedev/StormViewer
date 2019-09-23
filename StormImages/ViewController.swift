//
//  ViewController.swift
//  StormImages
//
//  Created by Mihai Leonte on 8/22/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var viewCount = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadImages), with: nil)
    }
    
    @objc func loadImages() {

        let fm = FileManager.default
        let path = Bundle.main.bundlePath
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        // Day 49: Challenge #1
        let defaults = UserDefaults.standard
        if let count = defaults.object(forKey: "viewCount") as? [Int] {
            viewCount = count
        } else {
            pictures.map { _ in viewCount.append(0) }
        }
        
        pictures.sort { $0 < $1 }
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "Views: " + String(viewCount[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        
            let image = pictures[indexPath.row]
            
            // Day 49: Challenge #1
            viewCount[indexPath.row] += 1
            let defaults = UserDefaults.standard
            defaults.set(viewCount, forKey: "viewCount")
            
            detailVC.selectedImage = image
            detailVC.currentIndex = indexPath.row
            detailVC.arrayCount = pictures.count
            navigationController?.pushViewController(detailVC, animated: true)
        
        }
        
    }

}

