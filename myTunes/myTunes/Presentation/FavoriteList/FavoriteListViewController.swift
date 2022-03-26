//
//  FavoriteListViewController.swift
//  myTunes
//
//  Created by MacOS on 26.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation
import UIKit
import Kingfisher

protocol FavoriteListDisplayLogic: AnyObject{
    func displayFavoriteList(viewModel: FavoriteList.Fetch.ViewModel)
}

final class FavoriteListViewController: UIViewController {
    
    var interactor: FavoriteListBusinessLogic?
    var router: (FavoriteListRoutingLogic & FavoriteListDataPassing)?
    var viewModel: FavoriteList.Fetch.ViewModel?
    var gridFlowLayout = GridFlowLayout()
    var favoritesList : [FavoriteList.Fetch.ViewModel.MyTunes] = []
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
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
        let interactor = FavoriteListInteractor(worker: FavoriteListWorker())
        let presenter = FavoriteListPresenter()
        let router = FavoriteListRouter()
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
        self.title = "FavoriteList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
        self.navigationController?.navigationBar.tintColor = UIColor.red

    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        favoritesCollectionView.collectionViewLayout = gridFlowLayout
        let nibTr = UINib(nibName: "TrackCollectionViewCell", bundle: nil)
        favoritesCollectionView.register(nibTr, forCellWithReuseIdentifier: "trackCell")
        let nibCl = UINib(nibName: "CollectionCollectionViewCell", bundle: nil)
        favoritesCollectionView.register(nibCl, forCellWithReuseIdentifier: "collectionCell")
        let nibAr = UINib(nibName: "ArtistCollectionViewCell", bundle: nil)
        favoritesCollectionView.register(nibAr, forCellWithReuseIdentifier: "artistCell")
    }
   
}

// MARK: - Display view model from City List Presenter

extension FavoriteListViewController : FavoriteListDisplayLogic{
    
    func displayFavoriteList(viewModel: FavoriteList.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}

extension FavoriteListViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trackCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! TrackCollectionViewCell? else {return UICollectionViewCell()}
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCollectionViewCell? else {return UICollectionViewCell()}
        guard let artistCell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistCollectionViewCell? else {return UICollectionViewCell()}
        
        let model = self.favoritesList[indexPath.item]
        
        switch model.wrapperType {
            
        case WrapperType.track.rawValue:
            trackCell.configureFavorites(model: model)
            return trackCell
            
        case WrapperType.artist.rawValue:
            artistCell.configureFavorites(model: model)
            return artistCell
            
        case WrapperType.collection.rawValue:
            collectionCell.configureFavorites(model: model)
            return collectionCell
            
        default:
            return trackCell
        }
    }
    
}