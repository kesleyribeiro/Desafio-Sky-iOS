//
//  Movie.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 6/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class Movie {
    
    var _title: String!
    var _image: String!
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var image: String {
        if _image == nil {
            _image = ""
        }
        return _image
    }

    init(movieDict: Dictionary<String, AnyObject>) {

        if let title = movieDict["title"] as? String {
            self._title = title
        }

        if let image = movieDict["cover_url"] as? String {
            self._image = image
        }        
    }

}
