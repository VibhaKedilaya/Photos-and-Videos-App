//
//  PexelsEndPoint.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum MovieApi {
    case video
    case images
    case favorites
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.pexels.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .video:
            return "/videos/popular"
        case .images:
            return "/v1/curated"
        case .favorites:
            return "/v1/curated"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .images:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .urlEncoding,
                                                urlParameters: nil,
                                                additionHeaders: ["Authorization":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


