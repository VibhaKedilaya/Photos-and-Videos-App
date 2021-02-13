//
//  HomeTableViewCell.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
    static let identifier: String = String(describing: HomeTableViewCell.self)
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var cellimageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.rounded()
            profileImageView.contentMode = .scaleToFill
            profileImageView.border(with: .white)
        }
    }
    
    @IBOutlet weak var profileName: UILabel! {
        didSet {
            profileName.text = ""
            profileName.textColor = .white
        }
    }
    
    
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "Facorite_home-deselet"), for: .normal)
            favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "Details-Favorite-slect"), for: .selected)
            favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.setBackgroundImage(#imageLiteral(resourceName: "Videoicon"), for: .normal)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "Pause"), for: .selected)
            playButton.isHidden = true
            playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI(homeTableViewModel: HomeTableViewModel) {
        if let imageURL = URL(string: homeTableViewModel.photographerImageURL) {
            profileImageView.setProfileImage(from: imageURL, placeHolder: #imageLiteral(resourceName: "download"))
        }
        if let imageString = homeTableViewModel.imageURL, let imageURL = URL(string: imageString) {
            cellimageView.setProfileImage(from: imageURL, placeHolder: nil)
        }
        playButton.isHidden = homeTableViewModel.cellType != .video
        favoriteButton.isSelected = homeTableViewModel.isFavorite
        profileName.text = homeTableViewModel.photographerName
    }
    
    // MARK: - Action Functions
    
    @objc
    func favoriteButtonClicked(_ sender: UIButton) {
        favoriteButton.isSelected = true
    }
    
    @objc
    func playButtonClicked(_ sender: UIButton) {
        playButton.isSelected = true
    }
}
