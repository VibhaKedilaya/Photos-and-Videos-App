//
//  Photo.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import Foundation

struct PhotosApiResponse {
    let page: Int
    let perPage: Int
    let photos: [Photo]
    let totalResults: Double
    let nextPage: String
}

extension PhotosApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos = "photos"
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        perPage = try container.decode(Int.self, forKey: .perPage)
        photos = try container.decode([Photo].self, forKey: .photos)
        totalResults = try container.decode(Double.self, forKey: .totalResults)
        nextPage = try container.decode(String.self, forKey: .nextPage)
    }
}

struct Photo {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String
    let src: [String: String]
    let liked: Bool
}

extension Photo: Decodable {
    private enum PhotoCodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographerUrl = "photographer_url"
        case photographerId = "photographer_id"
        case avgColor = "avg_color"
        case src
        case liked
    }
    
    init(from decoder: Decoder) throws {
        let photoContainer = try decoder.container(keyedBy: PhotoCodingKeys.self)
        
        id = try photoContainer.decode(Int.self, forKey: .id)
        width = try photoContainer.decode(Int.self, forKey: .width)
        height = try photoContainer.decode(Int.self, forKey: .height)
        url = try photoContainer.decode(String.self, forKey: .url)
        photographer = try photoContainer.decode(String.self, forKey: .photographer)
        photographerUrl = try photoContainer.decode(String.self, forKey: .photographerUrl)
        photographerId = try photoContainer.decode(Int.self, forKey: .photographerId)
        avgColor = try photoContainer.decode(String.self, forKey: .avgColor)
        src = try photoContainer.decode([String: String].self, forKey: .src)
        liked = try photoContainer.decode(Bool.self, forKey: .liked)
    }
}
