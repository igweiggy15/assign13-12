//
//  ViewController.swift
//  13Assign3
//
//  Created by Igwe Onumah on 12/16/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import UIKit

protocol ListDelegate: class {
    func passInformation(image: UIImage)
}

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    weak var delegate: ListDelegate?
    var imageVC: ImageViewController!
    
    var songs = [Songs]() {
        didSet {
            
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    var filteredSongs = [Songs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
    
    private func get() {
        SongManager.shared.getSongs { [weak self] sngs in
            self?.songs = sngs
            print("Song count: \(sngs.count)")
        }
    }
    
    private func setupList() {
        get()
        
        listTableView.register(UINib(nibName: ImageTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ImageTableCell.identifier)
        
        listTableView.tableFooterView = UIView(frame: .zero)
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableCell.identifier, for: indexPath) as! ImageTableCell
        
        let song = songs[indexPath.row]
        cell.titleLabel.text = "\(song.title)"
        cell.albumIdLabel.text = "Album: \(song.albumId) | Track: \(song.id)"
        
        if let thumbnailImage = song.thumbnailImage {
            cell.thumbnail.image = thumbnailImage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song =  songs[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        imageVC = storyboard?.instantiateViewController(identifier: "ImageViewController") as? ImageViewController
        if let fullImage = song.image {
            delegate?.passInformation(image: fullImage)
        } else {
            print("Whole Image is nil.")
        }
        
        present(imageVC, animated: true, completion: nil)
    }
    
}
