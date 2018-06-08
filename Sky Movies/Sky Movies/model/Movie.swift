//
//  Movie.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 6/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Movie {
    
    var _title: String!
    var _image: String!
    var _overview: String!
    var _duration: String!
    var _year: String!
    var _image2: String!
    var _image3: String!
    
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
    
    var overview: String {
        if _overview == nil {
            _overview = ""
        }
        return _overview
    }
    
    var duration: String {
        if _duration == nil {
            _duration = ""
        }
        return _duration
    }
    
    var year: String {
        if _year == nil {
            _year = ""
        }
        return _year
    }
    
    var image2: String {
        if _image2 == nil {
            _image2 = ""
        }
        return _image2
    }
    
    var image3: String {
        if _image3 == nil {
            _image3 = ""
        }
        return _image3
    }


    init(movieDict: Dictionary<String, AnyObject>) {

        if let title = movieDict["title"] as? String {
            self._title = title
        }

        if let image = movieDict["cover_url"] as? String {
            self._image = image
        }
        
        if let overview = movieDict["overview"] as? String {
            self._overview = overview
        }
        
        if let duration = movieDict["duration"] as? String {
            self._duration = duration
        }
        
        if let year = movieDict["release_year"] as? String {
            self._year = year
        }
        
        if let images = movieDict["backdrops_url"] as? [String] {
            
            if let image2 = images[0] as? String {
                self._image2 = image2
            }
            
            if let image3 = images[1] as? String {
                self._image3 = image3
            }
        }

    }

}
