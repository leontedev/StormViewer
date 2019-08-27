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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(recommendTapped))
        
        if let image = selectedImage {
            imageView.image = UIImage(named: image)
        }
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image data")
            return
        }
        
        guard let imageName = selectedImage else {
            return
        }
        
        print(imageName)
        
        let vc = UIActivityViewController(activityItems: [imageName, image], applicationActivities: [])
        // this is required for the iPad - as it needs to popover from a certain button (underneath it)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    
    @objc func recommendTapped() {
        let vc = UIActivityViewController(activityItems: ["StormImages is a great app with pictures of storms."], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
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
