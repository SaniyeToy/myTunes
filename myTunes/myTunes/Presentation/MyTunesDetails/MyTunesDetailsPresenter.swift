//
//  MyTunesDetailsPresenter.swift
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

protocol MyTunesDetailsPresentationLogic: AnyObject {
    func presentMyTunesDetails(response: MyTunesDetails.Fetch.Response)
    func shakeView()
    func snackBar(message: String)
    func alert(message: String ,title: String)
}

final class MyTunesDetailsPresenter: MyTunesDetailsPresentationLogic {
    weak var viewController: MyTunesDetailsDisplayLogic?
    var alert = Alert()
    
    func presentMyTunesDetails(response: MyTunesDetails.Fetch.Response) {
        
        viewController?.displayMyTunesDetails(viewModel: MyTunesDetails.Fetch.ViewModel(wrapperType: response.myTune?.wrapperType , kind: response.myTune?.kind, artistName: response.myTune?.artistName, collectionName: response.myTune?.collectionName, trackName: response.myTune?.trackName, artworkUrl100: response.myTune?.artworkUrl100, releaseDate: response.myTune?.releaseDate, country: response.myTune?.country, primaryGenreName: response.myTune?.primaryGenreName, artistViewUrl: response.myTune?.artistViewUrl, collectionViewUrl: response.myTune?.collectionViewUrl, trackViewUrl: response.myTune?.trackViewUrl
           )
        )
    }
    
    func shakeView(){
        viewController?.shakeView()
    }
    
    func snackBar(message: String) {
        viewController?.snackBar(message: message)
    }
    
    func alert(message: String ,title: String){
        Alert.alert(title: title, message: message)
    }
}
