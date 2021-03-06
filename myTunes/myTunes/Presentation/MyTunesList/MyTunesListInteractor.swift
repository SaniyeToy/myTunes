//
//  MyTunesListInteractor.swift
//  myTunes
//
//  Created by MacOS on 23.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol MyTunesListBusinessLogic: AnyObject {
    func fetchMyTunesList(params: [String: Any])
}

protocol MyTunesListDataStore {
    var myTunesList: [Results]? { get set }
}

final class MyTunesListInteractor: MyTunesListBusinessLogic, MyTunesListDataStore {
    var myTunesList: [Results]?
    var presenter: MyTunesListPresentationLogic?
    var worker: MyTunesListWorkingLogic
    
    init(worker: MyTunesListWorkingLogic) {
        self.worker = worker
    }
    
    func fetchMyTunesList(params: [String: Any]){
        
        self.worker.getMyTunesList(params: params) {[weak self] result in
            switch result {
            case .success(let response):
                self?.myTunesList = response.results
                guard let myTunesList = self?.myTunesList else { return }
                self?.presenter?.presentMyTunesList(response:  MyTunesList.Fetch.Response( myTunesList: myTunesList))
            case .failure(let error):
                self?.presenter?.alert(message: "Error", title: "\(error)")
            }
        }
    }
}
