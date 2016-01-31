//
//  Movie+CoreDataProperties.swift
//  Lecture-86-Exercise-Favorite-Movies
//
//  Created by Brian Lim on 1/10/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var imdb: String?
    @NSManaged var bgImage: NSData?
    @NSManaged var plot: String?

}
