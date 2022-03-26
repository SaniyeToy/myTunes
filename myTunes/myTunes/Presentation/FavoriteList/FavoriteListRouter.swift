//
//  FavoriteListRouter.swift
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

protocol FavoriteListRoutingLogic: AnyObject {
    func routeToDetails(index: Int)
    func popOver()
}

protocol FavoriteListDataPassing: AnyObject {
    var dataStore: FavoriteListDataStore? { get }
}

class FavoriteListRouter: FavoriteListRoutingLogic, FavoriteListDataPassing {
    weak var viewController: FavoriteListViewController?
    var dataStore: FavoriteListDataStore?
    
    func routeToDetails(index: Int) {
        let storyBoard = UIStoryboard(name: "MyTunesDetails", bundle: nil)
        let destVC: MyTunesDetailsViewController = storyBoard.instantiateViewController(identifier: "MyTunesDetails")
        let mytune = dataStore?.favoriteList?[index]
        destVC.router?.dataStore?.tune = mytune
        destVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func popOver(){
        viewController?.navigationController?.popViewController(animated: true)
    }
}
