//
//  MyTunesListRouter.swift
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

@objc protocol MyTunesListRoutingLogic: AnyObject {

}

protocol MyTunesListDataPassing: AnyObject {
    var dataStore: MyTunesListDataStore? { get }
}

final class MyTunesListRouter:  MyTunesListRoutingLogic, MyTunesListDataPassing {
    weak var viewController: MyTunesListViewController?
    var dataStore: MyTunesListDataStore?

}
