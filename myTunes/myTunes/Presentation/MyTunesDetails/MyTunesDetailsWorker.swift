//
//  MyTunesDetailsWorker.swift
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


protocol MyTunesDetailsWorkingLogic: AnyObject {
    func getFavoriteTunesList(completion: @escaping ((Result<[Tunes], Error>) -> Void))
    func addTune(wrapperType: String? , artistId : Int16 , collectionId : Int16 , trackId : Int16 , kind: String? , artistName: String?, collectionName: String?, trackName: String?, artworkUrl100: String? , releaseDate: String? , country: String? , primaryGenreName: String? , artistViewUrl: String?, collectionViewUrl: String?, trackViewUrl: String?)
}

final class MyTunesDetailsWorker: MyTunesDetailsWorkingLogic {
    
    func addTune(wrapperType: String? ,  artistId : Int16 , collectionId : Int16 , trackId : Int16 , kind: String? , artistName: String?, collectionName: String?, trackName: String?, artworkUrl100: String? , releaseDate: String? , country: String? , primaryGenreName: String? , artistViewUrl: String?, collectionViewUrl: String?, trackViewUrl: String?) {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var myTune = Tunes(context: managedContext)
        myTune.trackId = trackId
        myTune.collectionId = collectionId
        myTune.artistId = artistId
        myTune.wrapperType = wrapperType
        myTune.kind = kind
        myTune.artistName = artistName
        myTune.collectionName = collectionName
        myTune.trackName = trackName
        myTune.artworkUrl100 = artworkUrl100
        myTune.releaseDate = releaseDate
        myTune.country = country
        myTune.primaryGenreName = primaryGenreName
        myTune.artistViewUrl = artistViewUrl
        myTune.collectionViewUrl = collectionViewUrl
        myTune.trackViewUrl = trackViewUrl
        
        do {
            try managedContext.save()
            print("saved")
        }catch{
            print("error")
        }
    }
    
    
    func removeTune(object: Tunes) {
        let  managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(object)
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print("error")
        }
    }
    
    func getFavoriteTunesList(completion: @escaping ((Result<[Tunes], Error>) -> Void)) {
        
        do {
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var models = try managedContext.fetch(Tunes.fetchRequest())
            completion(.success(models))
        } catch {
            completion(.failure(error))
        }
    }
}
