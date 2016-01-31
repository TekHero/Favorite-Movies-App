//
//  Movie.swift
//  Lecture-86-Exercise-Favorite-Movies
//
//  Created by Brian Lim on 1/10/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Movie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    // When called, converts that image thats passed in
    // and converting that image into data
    // storing that data into the movie BgImage
    func setMovieImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.bgImage = data
    }
    
    // When called, converting the bgImage with data back into a UIImage
    // returning that image back to the caller
    func getMovieImage() -> UIImage {
        let img = UIImage(data: self.bgImage!)
        return img!
    }

}
