//
//  MyTunesDetailsViewController.swift
//  myTunes
//
//  Created by MacOS on 24.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher

protocol MyTunesDetailsDisplayLogic: AnyObject
{
    func displayMyTunesDetails(viewModel: MyTunesDetails.Fetch.ViewModel)
    func shakeView()
    func snackBar(message: String)
    
}

final class MyTunesDetailsViewController: UIViewController {
    var interactor: MyTunesDetailsBusinessLogic?
    var router: ( MyTunesDetailsRoutingLogic & MyTunesDetailsDataPassing)?
    var viewModel: MyTunesDetails.Fetch.ViewModel?
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var primaryGenreLabel: UILabel!
    @IBOutlet weak var addToFavorites: UIButton!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup Clean Code Design Pattern
    
    private func setup() {
        let viewController = self
        let interactor = MyTunesDetailsInteractor(worker: MyTunesDetailsWorker())
        let presenter = MyTunesDetailsPresenter()
        let router = MyTunesDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .systemMint
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchTunesList()
        interactor?.fetchMyTunesDetails()
        self.title = "Details"
    }
    
    @IBAction func addToFavoritesButton(_ sender: Any) {
        interactor?.addTuneToFavorites()
    }
}

// MARK: - display view model from MyTunesDetailsPresenter
extension MyTunesDetailsViewController:  MyTunesDetailsDisplayLogic {
    func snackBar(message: String) {
        AppSnackBar.make(in: self.view, message: "\(message) add  to favorites ", duration: .custom(1.0)).show()
    }
    
    func shakeView(){
        view.shake()
    }
    
    func displayMyTunesDetails(viewModel: MyTunesDetails.Fetch.ViewModel) {
        self.viewModel = viewModel
        detailsView.dropViewShadow()
        linkLabel.tintColor = .systemMint
        addToFavorites.layer.cornerRadius = 8
        detailsImageView.layer.cornerRadius = 8
        switch viewModel.wrapperType {
        case WrapperType.artist.rawValue:
            
            nameLabel.text = viewModel.artistName
            linkLabel.text = "View on iTunes Store"
            detailsLabel.text = viewModel.wrapperType
            primaryGenreLabel.text = viewModel.primaryGenreName
            linkLabel.addTapGesture {
                if let url = URL(string: (viewModel.artistViewUrl)!) {
                    UIApplication.shared.open(url)
                }
            }
            
        case WrapperType.collection.rawValue:
            
            nameLabel.text = viewModel.collectionName
            linkLabel.text = "View on iTunes Store"
            primaryGenreLabel.text = viewModel.primaryGenreName
            let dateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZ")
            detailsLabel.text = viewModel.releaseDate?.toDateString(dateFormatter: dateFormatter, outputFormat: "yyyy")
            detailsImageView.kf.setImage(with: URL(string: (viewModel.artworkUrl100) ?? ""))
            linkLabel.addTapGesture {
                if let url = URL(string: (viewModel.collectionViewUrl)!) {
                    UIApplication.shared.open(url)
                }
            }
            
        case WrapperType.track.rawValue:
            nameLabel.text = viewModel.trackName
            linkLabel.text = "View on iTunes Store"
            primaryGenreLabel.text = viewModel.primaryGenreName
            let dateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZ")
            detailsLabel.text = viewModel.releaseDate?.toDateString(dateFormatter: dateFormatter, outputFormat: "yyyy")
            detailsImageView.kf.setImage(with: URL(string: (viewModel.artworkUrl100) ?? ""))
            linkLabel.addTapGesture {
                if let url = URL(string: (viewModel.trackViewUrl)!) {
                    UIApplication.shared.open(url)
                }
            }
            
        default:
            break
        }
    }
}
