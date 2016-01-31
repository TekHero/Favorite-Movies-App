//
//  DetailVC.swift
//  Lecture-86-Exercise-Favorite-Movies
//
//  Created by Brian Lim on 1/10/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieIMDB: UILabel!
    
    
    var passedCellTitle: String?
    var passedCellDesc: String?
    var passedCellIMDB: String?
    var passedCellImage: UIImage?
    var passedPlot: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainImg.clipsToBounds = true
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        loadValues()
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadValues() {
        mainImg.image = passedCellImage
        movieTitle.text = passedCellTitle
        movieDesc.text = passedCellDesc
        moviePlot.text = passedPlot
        movieIMDB.text = passedCellIMDB
    }

}
