//
//  UIImageView+Additions.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import Foundation
import UIKit

public class ImageDownloadManager {
    
    // MARK: - Shared Instance
    public static let shared: ImageDownloadManager = ImageDownloadManager()
    
    // MARK: - Private Properties
    private lazy var operationQueue: OperationQueue = OperationQueue()
    
    // MARK: - Public Methods
    public func downloadImage(from url: URL, completion: @escaping ((_ downloadedImage: UIImage?, _ url: URL, _ error: Error?) -> Void)) {
        let imageDownloadOperation = ImageDownloadOperation(with: url)
        imageDownloadOperation.imageDownloadCompletion = { image, imageData, url, error in
            completion(image, url, error)
        }
        operationQueue.addOperation(imageDownloadOperation)
        
    }
}

private class ImageDownloadOperation: Foundation.Operation {
    
    private let url: URL
    
    var imageDownloadCompletion: ((_ image: UIImage?, _ imageData: Data?, _ url: URL, _ error: Error?) -> Void)?
    
    // MARK: - Designated Initialiser
    init(with url: URL) {
        self.url = url
        super.init()
        self.queuePriority = .high
        self.qualityOfService = .background
    }
    
    override func main() {
        downloadImage()
    }
    
    private func downloadImage() {
        URLSession.shared.dataTask(with: self.url) { data, response, error in
            if let unwrappedData = data,
               let unwrappedURL = response?.url,
               let image = UIImage(data: unwrappedData) {
                self.imageDownloadCompletion?(image, unwrappedData, unwrappedURL, error)
            } else {
                self.imageDownloadCompletion?(nil, nil, self.url, error)
            }
        }
        .resume()
    }
}

extension UIImageView {
    public func setProfileImage(from url: URL?,
                                placeHolder: UIImage?,
                                shouldRefresh: Bool = true,
                                showLoader: Bool = false,
                                animated: Bool = false,
                                completion: (() -> Void)? = nil) {
        // refresh will flag to switch between placeholder and original image
        // introduced to avoid having blink on navigation bar profileImage
        if shouldRefresh && (self.image == nil) {
            image = placeHolder
        }
        if let unwrappedURL = url {
            if showLoader {
                addLoader()
            }
            ImageDownloadManager.shared.downloadImage(from: unwrappedURL) { [weak self] image, url, _ in
                DispatchQueue.main.async {
                    self?.removeLoaderIfAdded()
                    if let downloadedImage = image,
                       url == unwrappedURL {
                        self?.setImage(image: downloadedImage, animated: animated, completion: completion)
                    } else {
                        self?.setImage(image: placeHolder, animated: animated, completion: completion)
                    }
                }
            }
        } else {
            // set place holder
            self.removeLoaderIfAdded()
            self.setImage(image: placeHolder, animated: animated, completion: completion)
        }
    }
    
    private func setImage(image: UIImage?, animated: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if animated {
                self.alpha = 0.5
                UIView.animate(withDuration: 0.3) {
                    self.image = image
                    self.alpha = 1
                }
            } else {
                self.alpha = 1
                self.image = image
            }
            // call completion
            completion?()
        }
    }
    
    public func addLoader() {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        self.addSubview(activityIndicator)
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        self.layoutIfNeeded()
    }
    
    func removeLoaderIfAdded() {
        if !subviews.isEmpty,
           let activityIndicatorView = subviews.first as? UIActivityIndicatorView {
            activityIndicatorView.removeFromSuperview()
        }
    }
}
