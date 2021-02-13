//
//  HomeViewController.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleILabel: UILabel! {
        didSet {
            titleILabel.text = "Discover the world’s best photos & videos"
            titleILabel.textColor = .white
            titleILabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.text = "Best memories online"
            subTitleLabel.textColor = .white
            subTitleLabel.textAlignment = .center
        }
    }
    
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.placeholder = "Search photos, videos, artists"
        }
    }
    
    @IBOutlet weak var photosButtonSliderView: UIView! {
        didSet {
            photosButtonSliderView.isHidden = true
        }
    }
    
    @IBOutlet weak var videoButtonSliderView: UIView! {
        didSet {
            videoButtonSliderView.isHidden = true
        }
    }
    
    @IBOutlet weak var favoritesButtonSliderView: UIView! {
        didSet {
            favoritesButtonSliderView.isHidden = true
        }
    }
    
    @IBOutlet weak var searchBarBackgroundView: UIView! {
        didSet {
            searchBarBackgroundView.layer.cornerRadius = 4
            searchBarBackgroundView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var photosButton: UIButton! {
        didSet {
            photosButton.titleLabel?.text = "Photos"
            photosButton.setTitleColor(UIColor.lightGreyColor, for: .normal)
            photosButton.setTitleColor(UIColor.pinkColor, for: .selected)
            photosButton.titleLabel?.textAlignment = .center
            photosButton.addTarget(self, action: #selector(photosButtonClicked), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var videoButton: UIButton! {
        didSet {
            videoButton.titleLabel?.text = "Videos"
            videoButton.setTitleColor(UIColor.lightGreyColor, for: .normal)
            videoButton.setTitleColor(UIColor.pinkColor, for: .selected)
            videoButton.titleLabel?.textAlignment = .center
            videoButton.addTarget(self, action: #selector(videoButtonClicked), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var favoritesButton: UIButton! {
        didSet {
            favoritesButton.titleLabel?.text = "Favorites"
            favoritesButton.setTitleColor(UIColor.lightGreyColor, for: .normal)
            favoritesButton.setTitleColor(UIColor.pinkColor, for: .selected)
            favoritesButton.titleLabel?.textAlignment = .center
            favoritesButton.addTarget(self, action: #selector(favoritesButtonClicked), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - private function
    
    private func setUpUI() {
        tableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getNewImages() { result in
            if result {
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        }
        viewModel.cellType = .image
        photosButton.isSelected = true
        videoButton.isSelected = false
        favoritesButton.isSelected = false
        photosButtonSliderView.isHidden = false
        favoritesButtonSliderView.isHidden = true
        videoButtonSliderView.isHidden = true
    }
    
    // MARK: - Action Functions
    
    @objc
    func photosButtonClicked(_ sender: UIButton) {
        viewModel.cellType = .image
        photosButton.isSelected = true
        videoButton.isSelected = false
        favoritesButton.isSelected = false
        photosButtonSliderView.isHidden = false
        favoritesButtonSliderView.isHidden = true
        videoButtonSliderView.isHidden = true
    }
    
    @objc
    func videoButtonClicked(_ sender: UIButton) {
        viewModel.cellType = .video
        photosButton.isSelected = false
        videoButton.isSelected = true
        favoritesButton.isSelected = false
        photosButtonSliderView.isHidden = true
        favoritesButtonSliderView.isHidden = true
        videoButtonSliderView.isHidden = false
    }
    
    @objc
    func favoritesButtonClicked(_ sender: UIButton) {
        viewModel.cellType = .favorite
        photosButton.isSelected = false
        videoButton.isSelected = false
        favoritesButton.isSelected = true
        photosButtonSliderView.isHidden = true
        favoritesButtonSliderView.isHidden = false
        videoButtonSliderView.isHidden = true
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.cellType {
        case .video:
            return viewModel.videoArray?.count ?? 0
        default:
            return viewModel.photosArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        switch viewModel.cellType {
        case .video:
            if let video = viewModel.videoArray?[indexPath.row] {
                
                let homeTableViewModel = HomeTableViewModel(imageURL: video.image, photographerName: video.user.name, photographerImageURL: video.user.url, isFavorite: false, cellType: viewModel.cellType)
                cell.setUpUI(homeTableViewModel: homeTableViewModel)
            }
        default:
            if let photo = viewModel.photosArray?[indexPath.row] {
                
                let homeTableViewModel = HomeTableViewModel(imageURL: photo.src["portrait"], photographerName: photo.photographer, photographerImageURL: photo.photographerUrl, isFavorite: photo.liked, cellType: viewModel.cellType)
                cell.setUpUI(homeTableViewModel: homeTableViewModel)
            }
        }
        return cell
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // don't force `endEditing` if you want to be asked for resigning
            // also return real flow value, not strict, like: true / false
            return textField.endEditing(false)
        }
}
