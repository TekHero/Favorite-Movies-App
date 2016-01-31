//
//  MovieCell.swift
//  Lecture-86-Exercise-Favorite-Movies
//
//  Created by Brian Lim on 1/10/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var bgImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgImage.contentMode = UIViewContentMode.ScaleAspectFill
        bgImage.clipsToBounds = true
    }
    
    func configureCell(movie: Movie) {
        title.text = movie.title
        desc.text = movie.desc
        imdb.text = movie.imdb
        // Calling the getMovieImage() function 
        // which converts the bgImage of the movie back into a UIImage
        // Then returns that image, so what this is saying, is that the image that user chooses, gets set as the bgimage of the cell
        bgImage.image = movie.getMovieImage()
    }

}
