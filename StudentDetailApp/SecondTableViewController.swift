//
//  SecondTableViewController.swift
//  StudentDetailApp
//
//  Created by raja A on 4/20/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class SecondTableViewController: UIViewController, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var showImage: UIImageView!
    @IBOutlet var nameLab: UILabel!
    @IBOutlet var colleageLab: UILabel!
    @IBOutlet var phoneLab: UILabel!
    @IBOutlet var dobLab: UILabel!
    @IBOutlet var genderlab: UILabel!
    var name: String!
    var colleageName: String!
    var contact: String!
    var dob: String!
    var gender: String!
    var myImage: UIImage!
    var picker:UIImagePickerController?=UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLab.text = name
        colleageLab.text = colleageName
        dobLab.text = dob
        phoneLab.text = contact
        genderlab.text = gender
        showImage.image = myImage
        
         picker?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPhotoBtn(_ sender: UIBarButtonItem) {
        openPhotoLibrary()
    }
    
    func openPhotoLibrary() {
        
        picker?.allowsEditing = true
        picker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chooseImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        showImage.contentMode = .scaleAspectFit
        showImage.image = myImage
        myImage = chooseImage
        dismiss(animated: true, completion: nil)
        
    }
    
}
