//
//  ImageViewController.swift
//  13Assign3
//
//  Created by Igwe Onumah on 12/16/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import UIKit


class ImageViewController: UIViewController {

    @IBOutlet weak var fullImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ImageViewController: ListDelegate {
    func passInformation(image: UIImage) {
        fullImage.image = image
    }
}

extension CollectionViewController: CollectionDelegate {
    func passInformation(image: UIImage) {
    }
}

