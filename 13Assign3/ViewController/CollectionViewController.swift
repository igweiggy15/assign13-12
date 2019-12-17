//
//  CollectionViewController.swift
//  13Assign3
//
//  Created by Igwe Onumah on 12/16/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import UIKit

protocol CollectionDelegate: class {
    func passInformation(image: UIImage)
}

class CollectionViewController: UIViewController {

  @IBOutlet weak var albumLabel: UILabel!
  @IBOutlet weak var albumImage: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
//        = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollecitonCell")
//        return cv
//    }()
    
    weak var delegate: CollectionDelegate?
    var imageVC: ImageViewController!
    
    var orderedSongs: [String: [Songs]] = [:] {
        didSet {
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    
    var songs = [Songs]() {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
    }
    
        private func get() {
        SongManager.shared.getSongs { [weak self] sngs in
            self?.songs = sngs
            print("Song count (collection view): \(sngs.count)")
        }
    }
    
    private func setupCollection() {
        get()
        
        // Register XIB Cell View to collection view
        //collectionView.register(UINib(nibName: "CollectionCell", bundle: Bundle.main), forCellReuseIdentifier: "CollectionCell")
    }
    
    private func orderByAlbum() {
    }
    

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        return cell
    }
        
    
}
