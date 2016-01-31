//
//  ViewController.swift
//  Lecture-86-Exercise-Favorite-Movies
//
//  Created by Brian Lim on 1/9/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    
    // Variables to hold values in which are used to pass over to the detailVC
    var cellTitle: String!
    var cellDesc: String!
    var cellIMDB: String!
    var cellImage: UIImage!
    var moviePlot: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Creating a image view & initializing it with an image & setting it to aspect fill
        let imageView: UIImageView = UIImageView.init(image: UIImage(named: "Favorite-Movies"))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        // Creating a UIView with a custom frame to match the nav bar title view
        let titleView = UIView.init(frame: CGRectMake(0, 0, 44, 44))
        // Setting the image view's frame to be equal to the new title view's bounds
        imageView.frame = titleView.bounds
        // adding the image view as a subview to the title view
        titleView.addSubview(imageView)
        // setting the nav bar titleView to be equal to the custom one
        self.navigationItem.titleView = titleView
        
        // Creating a image view & initializing it with an image
        let imgView: UIImageView = UIImageView.init(image: UIImage(named: "Modern-Black-Wallpaper"))
        // setting the tableView's background view to the newly created image view
        tableView.backgroundView = imgView
        imgView.reloadInputViews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        fetchAndSetRequests()
        tableView.reloadData()
    }
    
    func fetchAndSetRequests() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.movies = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as? MovieCell {
            cell.configureCell(movie)
            return cell
        } else {
            let cell = MovieCell()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Checking to see if the editing style is the delete function
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Getting a reference to the app delegate & its managedObjectText
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            
            // Deleting the object in the movies array at the current index & casting that data as a NSManagedObject
            context.deleteObject(movies[indexPath.row] as NSManagedObject)
            // Removing the item in the movies array at the current index
            movies.removeAtIndex(indexPath.row)
            
            do {
                // trying to save the context
                try context.save()
            } catch let err as NSError {
                print(err.debugDescription)
            }
            // Adding the animation to the cell when it is needed & reloading the table view
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let movie = movies[indexPath.row]
        emptyValues()
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! MovieCell
        cellTitle = currentCell.title.text
        cellDesc = currentCell.desc.text
        cellIMDB = currentCell.imdb.text
        cellImage = currentCell.bgImage.image
        moviePlot = movie.plot
        performSegueWithIdentifier("detailVC", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailVC" {
            
            let detailVC = segue.destinationViewController as! DetailVC
            detailVC.passedCellTitle = cellTitle
            detailVC.passedCellDesc = cellDesc
            detailVC.passedCellIMDB = cellIMDB
            detailVC.passedCellImage = cellImage
            detailVC.passedPlot = moviePlot
        }
    }
    
    func emptyValues() {
        cellTitle = ""
        cellDesc = ""
        cellIMDB = ""
        cellImage = nil
        moviePlot = ""
    }
}

