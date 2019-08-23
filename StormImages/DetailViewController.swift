//
//  DetailViewController.swift
//  StormImages
//
//  Created by Mihai Leonte on 8/23/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var currentIndex: Int?
    var arrayCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentIndex = currentIndex else { return }
        guard let arrayCount = arrayCount else { return }
        
        // both are Optionals, so we don't have to unwrap image
        title = "Picture \(String(currentIndex+1)) of \(String(arrayCount))"
        navigationItem.largeTitleDisplayMode = .never
        
        if let image = selectedImage {
            imageView.image = UIImage(named: image)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
}
