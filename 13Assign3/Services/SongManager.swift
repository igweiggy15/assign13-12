//
//  SongManager.swift
//  13Assign3
//
//  Created by Igwe Onumah on 12/16/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import Foundation
import UIKit

typealias SongHandler = ([Songs]) -> Void

final class SongManager {
    
    static let shared = SongManager()
    
    private init () {}
    
    func getSongs(completion: @escaping SongHandler) {
        guard let path = Bundle.main.path(forResource: "songslist", ofType: "json") else {
            completion([])
            return
        }
        
        // Container to hold songs
        var songs = [Songs]()
        
        DispatchQueue.global().async {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let songsDict = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                for dict in songsDict {
                    guard let title = dict["title"] as? String,
                        let imageUrl = dict["url"] as? String,
                        let thumbnailUrl = dict["thumbnailUrl"] as? String,
                        let albumId = dict["albumId"] as? Int,
                        let id = dict["id"] as? Int else { continue }
                    
                        let thumbnailConvert = URL(string: thumbnailUrl)
                        var thumbnailImage: UIImage?
                    
                    let task = URLSession.shared.dataTask(with: thumbnailConvert!) { data, response, error in
                        guard let data = data else { return }
                        
                        DispatchQueue.main.async() {
                            thumbnailImage = UIImage(data: data)
                        }
                    }
                    task.resume()
                    
                    let songs = Songs(title: title, imageUrl: imageUrl, thumbnailUrl: thumbnailUrl, albumId: albumId, id: id, thumbnailImage: thumbnailImage, image: <#UIImage?#>)
                    
                    songs.append(songs)
                }
                
                completion(songs)
            } catch {
                completion([])
                print("Couldn't serialize JSON: \(error.localizedDescription)")
                return
            }
        }
    }
    
}
