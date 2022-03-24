//
//  MyTunesDetailsInteractor.swift
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

protocol MyTunesDetailsBusinessLogic: AnyObject {
   
}

protocol MyTunesDetailsDataStore:AnyObject {
    var myTune: Results? { get set }
}

final class MyTunesDetailsInteractor: MyTunesDetailsBusinessLogic, MyTunesDetailsDataStore {
    var myTune: Results?
    
    var presenter: MyTunesDetailsPresentationLogic?
    var worker: MyTunesDetailsWorkingLogic?

    init(worker: MyTunesDetailsWorkingLogic) {
        self.worker = worker
    }
}
