//
//  HomeViewModel.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import Foundation

enum CellType {
    case image
    case video
    case favorite
}
 
class HomeViewModel {
    var photosArray: [Photo]? = nil
    var videoArray: [Video]? = nil
    var cellType: CellType = .image
    var networkManager = NetworkManager()
    
    func getNewImages(completion: @escaping (_ result: Bool)->())  {
        networkManager.getNewImages() { result, error in
            self.photosArray = result
            completion(result != nil)
        }
    }
    
    func getNewVideo(completion: @escaping (_ result: Bool)->())  {
        networkManager.getNewVideos() { result, error in
            self.videoArray = result
            completion(result != nil)
        }
    }
    
    func getNewVideo(search: String, completion: @escaping (_ result: Bool)->())  {
        networkManager.getNewVideos() { result, error in
            self.videoArray = result
            completion(result != nil)
        }
    }
}
