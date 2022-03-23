//
//  MyTunesListWorker.swift
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

protocol MyTunesListWorkingLogic: AnyObject {
    func getMyTunesList(params: [String: Any], completion: @escaping ((Result<[ListResponse], Error>) -> Void))
}

final class MyTunesListWorker: MyTunesListWorkingLogic {
    //use case
    func getMyTunesList(params: [String: Any], completion: @escaping ((Result<[ListResponse], Error>) -> Void)) {
        ApiClient.request(ApiEndPoint.list(params: params)) {(_ result: Result<[ListResponse], Error>) in
            completion(result)
        }
    }
}



