//
//  MyTunesDetailsModels.swift
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

enum MyTunesDetails
{
    
    enum Fetch
    {
        struct Response
        {
            var myTune: Results?
        }
        
        struct ViewModel
        {
            var wrapperType : String?
            var kind : String?
            var artistId : Int?
            var artistName : String?
            var collectionName : String?
            var trackName : String?
            var artworkUrl30 : String?
            var artworkUrl60 : String?
            var artworkUrl100 : String?
            var releaseDate : String?
            var country : String?
            var primaryGenreName : String?
            var artistViewUrl : String?
            var collectionViewUrl : String?
            var trackViewUrl : String?
        }
    }
}
