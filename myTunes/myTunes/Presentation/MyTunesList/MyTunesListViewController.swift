//
//  MyTunesListViewController.swift
//  myTunes
//
//  Created by MacOS on 23.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher
import McPicker

protocol MyTunesListDisplayLogic: AnyObject
{
    func displayMyTunes(viewModel: MyTunesList.Fetch.ViewModel)
    
}

final class MyTunesListViewController: UIViewController {
    
    var interactor: MyTunesListBusinessLogic?
    var router: ( MyTunesListRoutingLogic & MyTunesListDataPassing)?
    var viewModel: MyTunesList.Fetch.ViewModel?
    var gridFlowLayout = GridFlowLayout()
    let filter : [String] = [Media.movie.rawValue, Media.podcast.rawValue, Media.music.rawValue, Media.musicVideo.rawValue, Media.audiobook.rawValue, Media.shortFilm.rawValue, Media.tvShow.rawValue , Media.software.rawValue, Media.ebook.rawValue, Media.all.rawValue]
    var trackList = [MyTunesList.Fetch.ViewModel.MyTunes]()
    var collectionList = [MyTunesList.Fetch.ViewModel.MyTunes]()
    var artistList = [MyTunesList.Fetch.ViewModel.MyTunes]()
    var myTunesList : [MyTunesList.Fetch.ViewModel.MyTunes] = []
    
    @IBOutlet weak var myTunesSearchBar: UISearchBar!
    @IBOutlet weak var myTunesCollectionView: UICollectionView!
    @IBOutlet weak var selectKindButton: UIButton!
    @IBOutlet weak var wrapperTypeSegmentedController: UISegmentedControl!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var params = [String:Any](){
        didSet{
            if myTunesSearchBar.text != ""{
                interactor?.fetchMyTunesList(params: params)
                wrapperTypeSegmentedController.selectedSegmentIndex = 0
            }else {
                
            }
        }
    }
    
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
        let interactor = MyTunesListInteractor(worker: MyTunesListWorker())
        let presenter = MyTunesListPresenter()
        let router = MyTunesListRouter()
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.title = "MyTunesList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemMint]
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        selectKindButton.setImage(UIImage(named: "filter")?.withRenderingMode(.alwaysTemplate), for: .normal)
        selectKindButton.tintColor = .systemMint
        favoritesButton.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoritesButton.tintColor = .systemMint
        myTunesCollectionView.collectionViewLayout = gridFlowLayout
        let nibTr = UINib(nibName: "TrackCollectionViewCell", bundle: nil)
        myTunesCollectionView.register(nibTr, forCellWithReuseIdentifier: "trackCell")
        let nibCl = UINib(nibName: "CollectionCollectionViewCell", bundle: nil)
        myTunesCollectionView.register(nibCl, forCellWithReuseIdentifier: "collectionCell")
        let nibAr = UINib(nibName: "ArtistCollectionViewCell", bundle: nil)
        myTunesCollectionView.register(nibAr, forCellWithReuseIdentifier: "artistCell")
    }
    
    @IBAction func favoritesButton(_ sender: Any) {
        router?.routeToFavorites()
    }
    
    @IBAction func wrapperTypeSegmentedController(_ sender: UISegmentedControl) {
        
        if self.viewModel?.myTunesList != nil{
            switch sender.selectedSegmentIndex{
            case 0:
                self.myTunesList = self.viewModel!.myTunesList
                guard let searchText = myTunesSearchBar.text else { return }
                self.params["term"] = searchText
                
            case 1:
                self.myTunesList = viewModel!.myTunesList
                var filteredData = [MyTunesList.Fetch.ViewModel.MyTunes]()
                for tunes in (self.myTunesList) {
                    let wrapperType = tunes.wrapperType
                    if wrapperType!.contains(WrapperType.track.rawValue){
                        filteredData.append(tunes)
                    }
                }
                self.myTunesList.removeAll()
                self.myTunesList.append(contentsOf: filteredData)
                self.myTunesCollectionView.reloadData()
                
            case 2:
                self.myTunesList = viewModel!.myTunesList
                var filteredData = [MyTunesList.Fetch.ViewModel.MyTunes]()
                for tunes in (self.myTunesList) {
                    let wrapperType = tunes.wrapperType
                    if wrapperType!.contains(WrapperType.artist.rawValue){
                        filteredData.append(tunes)
                    }
                }
                self.myTunesList.removeAll()
                self.myTunesList.append(contentsOf: filteredData)
                self.myTunesCollectionView.reloadData()
                                
            case 3:
                self.myTunesList = viewModel!.myTunesList
                var filteredData = [MyTunesList.Fetch.ViewModel.MyTunes]()
                for tunes in (self.viewModel?.myTunesList)! {
                    let wrapperType = tunes.wrapperType
                    if wrapperType!.contains(WrapperType.collection.rawValue){
                        filteredData.append(tunes)
                    }
                }
                self.myTunesList.removeAll()
                self.myTunesList.append(contentsOf: filteredData)
                self.myTunesCollectionView.reloadData()
                
            default:
                break
            }
        }else {
            
        }
    }
    
    @IBAction func selectKindButton(_ sender: Any) {
        showPicker(selectKindButton, list: filter )
    }
    
    func showPicker(_ sender: UIButton, list: [String]){
        McPicker.showAsPopover(data:[list], fromViewController: self, sourceView: sender, doneHandler:{ [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                
                switch name {
                    
                case  Media.movie.rawValue:
                    self?.params["media"] =  Media.movie.rawValue
                    
                case Media.podcast.rawValue:
                    self?.params["media"] = Media.podcast.rawValue
                    
                case Media.music.rawValue:
                    self?.params["media"] = Media.music.rawValue
                    
                case  Media.musicVideo.rawValue:
                    self?.params["media"] =  Media.musicVideo.rawValue
                    
                case Media.audiobook.rawValue:
                    self?.params["media"] = Media.audiobook.rawValue
                    
                case Media.shortFilm.rawValue:
                    self?.params["media"] = Media.shortFilm.rawValue
                    
                case Media.tvShow.rawValue:
                    self?.params["media"] = Media.tvShow.rawValue
                    
                case Media.software.rawValue:
                    self?.params["media"] = Media.software.rawValue
                    
                case Media.ebook.rawValue:
                    self?.params["media"] = Media.ebook.rawValue
                    
                case  Media.all.rawValue:
                    self?.params["media"] =  Media.all.rawValue
                    
                default:
                    break
                }
            }
        }
    )}
}

extension MyTunesListViewController: MyTunesListDisplayLogic{
    func displayMyTunes(viewModel: MyTunesList.Fetch.ViewModel)
    {
        self.viewModel = viewModel
        self.myTunesList = viewModel.myTunesList
        myTunesCollectionView.reloadData()
    }
}

extension MyTunesListViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTunesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trackCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! TrackCollectionViewCell? else {return UICollectionViewCell()}
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCollectionViewCell? else {return UICollectionViewCell()}
        guard let artistCell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistCollectionViewCell? else {return UICollectionViewCell()}
        
        let model = self.myTunesList[indexPath.item]
        
        switch model.wrapperType {
            
        case WrapperType.track.rawValue:
            trackCell.configure(model: model)
            return trackCell
            
        case WrapperType.artist.rawValue:
            artistCell.configure(model: model)
            return artistCell
            
        case WrapperType.collection.rawValue:
            collectionCell.configure(model: model)
            return collectionCell
            
        default:
            return trackCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToDetails(index: indexPath.item)
    }
}

// MARK: - SearchBar Delegate

extension MyTunesListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(MyTunesListViewController.reload), object: nil)
        self.perform(#selector(MyTunesListViewController.reload), with: nil, afterDelay: 1)
    }
    
    @objc func reload() {
        guard let searchText = myTunesSearchBar.text else { return }
        
        if searchText == "" {
            params.removeAll()
            wrapperTypeSegmentedController.selectedSegmentIndex = 0
            self.viewModel?.myTunesList.removeAll()
            myTunesCollectionView.reloadData()
        } else {
            search(searchText: searchText)
        }
    }
    
    func search(searchText: String){
        params.removeAll()
        params["limit"] = "25"
        params["term"] = searchText
        print(params)
    }
}

