//
//  Video.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import Foundation

struct VideosApiResponse {
    let page: Int
    let perPage: Int
    let videos: [Video]
    let url: String
}

extension VideosApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case videos = "photos"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        perPage = try container.decode(Int.self, forKey: .perPage)
        videos = try container.decode([Video].self, forKey: .videos)
        url = try container.decode(String.self, forKey: .url)
    }
}

struct Video {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let image: String
    let duration: Int
    let avgColor: String
    let user: User
    let videoFiles: [VideoFile]
    let videoPictures: [VideoPicture]
}

extension Video: Decodable {
    private enum PhotoCodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case image
        case duration
        case avgColor = "avg_color"
        case user
        case liked
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
    
    init(from decoder: Decoder) throws {
        let videoContainer = try decoder.container(keyedBy: PhotoCodingKeys.self)
        
        id = try videoContainer.decode(Int.self, forKey: .id)
        width = try videoContainer.decode(Int.self, forKey: .width)
        height = try videoContainer.decode(Int.self, forKey: .height)
        url = try videoContainer.decode(String.self, forKey: .url)
        image = try videoContainer.decode(String.self, forKey: .image)
        duration = try videoContainer.decode(Int.self, forKey: .duration)
        avgColor = try videoContainer.decode(String.self, forKey: .avgColor)
        user = try videoContainer.decode(User.self, forKey: .user)
        videoFiles = try videoContainer.decode([VideoFile].self, forKey: .videoFiles)
        videoPictures = try videoContainer.decode([VideoPicture].self, forKey: .videoPictures)
    }
}

struct User {
    let id: Int
    let name: String
    let url: String
}

extension User: Decodable {
    private enum PhotoCodingKeys: String, CodingKey {
        case id
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: PhotoCodingKeys.self)
        
        id = try userContainer.decode(Int.self, forKey: .id)
        name = try userContainer.decode(String.self, forKey: .name)
        url = try userContainer.decode(String.self, forKey: .url)
    }
}

struct VideoFile {
    let id: Int
    let quality: String
    let fileType: String
    let width: Int
    let height: Int
    let link: String
}

extension VideoFile: Decodable {
    private enum videoFileCodingKeys: String, CodingKey {
        case id
        case quality
        case fileType = "file_type"
        case width
        case height
        case link
    }
    
    init(from decoder: Decoder) throws {
        let videoFileContainer = try decoder.container(keyedBy: videoFileCodingKeys.self)
        
        id = try videoFileContainer.decode(Int.self, forKey: .id)
        quality = try videoFileContainer.decode(String.self, forKey: .quality)
        fileType = try videoFileContainer.decode(String.self, forKey: .fileType)
        width = try videoFileContainer.decode(Int.self, forKey: .width)
        height = try videoFileContainer.decode(Int.self, forKey: .height)
        link = try videoFileContainer.decode(String.self, forKey: .link)
    }
}

struct VideoPicture {
    let id: Int
    let picture: String
    let nr: String
}

extension VideoPicture: Decodable {
    private enum videoPictureCodingKeys: String, CodingKey {
        case id
        case picture
        case nr
    }
    
    init(from decoder: Decoder) throws {
        let videoPictureContainer = try decoder.container(keyedBy: videoPictureCodingKeys.self)
        
        id = try videoPictureContainer.decode(Int.self, forKey: .id)
        picture = try videoPictureContainer.decode(String.self, forKey: .picture)
        nr = try videoPictureContainer.decode(String.self, forKey: .nr)
        
    }
}
