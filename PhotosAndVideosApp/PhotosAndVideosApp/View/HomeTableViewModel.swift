//
//  HomeTableViewModel.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import Foundation
import UIKit

struct HomeTableViewModel {
    var imageURL: String?
    var photographerName: String
    var photographerImageURL: String
    var isFavorite: Bool
    var cellType: CellType
    
    init(imageURL: String?, photographerName: String, photographerImageURL: String, isFavorite: Bool, cellType: CellType) {
        self.imageURL = imageURL
        self.photographerName = photographerName
        self.photographerImageURL = photographerImageURL
        self.isFavorite = isFavorite
        self.cellType = cellType
    }
    
    func getImageFromURL(url: String) -> UIImage? {
        if let url = URL(string: url),
           let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
}
