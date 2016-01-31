//
//  AddMovieVC.swift
//  Lecture-86-Exercise-Favorite-Movies
//
//  Created by Brian Lim on 1/10/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit
import CoreData

class AddMovieVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var IMDBTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var plotTextField: UITextField!
    @IBOutlet weak var movieImg: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        movieImg.layer.cornerRadius = 5.0
        movieImg.clipsToBounds = true
        
        titleTextField.delegate = self
        IMDBTextField.delegate = self
        descTextField.delegate = self
        plotTextField.delegate = self
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard:"))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        let barButton: UIBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: Selector("dismissVC"))
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @IBAction func addImgBtnPressed(sender: AnyObject) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func addMovieBtnPressed(sender: AnyObject) {
        // Checking to see if there is user input in the titleTextField
        if let title = titleTextField.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
            movie.title = title
            movie.desc = descTextField.text
            movie.imdb = IMDBTextField.text
            movie.plot = plotTextField.text
            // Calling the setMovieImage() function on the new movie
            // Which passes in the movieImg of the usersImage in the function
            // then converts that image into data and stores that data into the bgImage of the cell
            movie.setMovieImage(movieImg.image!)
            
            context.insertObject(movie)
            
            do {
                try context.save()
            } catch {
                print("Could not save movie")
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // dismisses the image picker controller
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        // stores the image that the user picked into the movieImg variable
        movieImg.image = image
    }
    
    // -------------------------------- //
        // Dismissing view controllers
        // and keyboards
    
    func dismissVC() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard(tapGesture: UITapGestureRecognizer) {
        titleTextField.resignFirstResponder()
        IMDBTextField.resignFirstResponder()
        descTextField.resignFirstResponder()
        plotTextField.resignFirstResponder()
    }
    
}
