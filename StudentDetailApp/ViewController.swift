//
//  ViewController.swift
//  StudentDetailApp
//
//  Created by raja A on 4/19/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit
var arrayOf = [studentList]()

class ViewController: UIViewController, UITextFieldDelegate , UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var imageViews: UIImage?
    var picker:UIImagePickerController?=UIImagePickerController()
   
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var viewButton: UIButton!
    @IBOutlet var studentNameTxt: UITextField!
    @IBOutlet var studentSchoolNameTxt: UITextField!
    @IBOutlet var studentContactNoTxt: UITextField!
    @IBOutlet var studentDOBTxt: UITextField!
    @IBOutlet var genderTxt: UILabel!
    @IBOutlet var segmentController: UISegmentedControl!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = .white
        toolBar.backgroundColor = .black
        let todatBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.tappedBarBtn))
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 17)
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "Selected a due data"
        label.textAlignment = NSTextAlignment.center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([todatBtn, flexSpace, textBtn,okBarBtn], animated: true)
        studentDOBTxt.inputAccessoryView = toolBar
        picker?.delegate = self
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func donePressed(_ sender: UIBarButtonItem) {
        studentDOBTxt.resignFirstResponder()
    }
    
    func tappedBarBtn(_ sender: UIBarButtonItem) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "MMM d, yyyy, hh:mm a zz"
        studentDOBTxt.text = dateFormatter.string(from: Date())
        studentDOBTxt.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func selectedItems(_ sender: UISegmentedControl) {
        
        if segmentController.selectedSegmentIndex == 0 {
            genderTxt.text = "Male"
        } else if segmentController.selectedSegmentIndex == 1{
            genderTxt.text = "Female"
        }
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let datefomatter = DateFormatter()
        datefomatter.dateStyle = DateFormatter.Style.medium
        datefomatter.timeStyle = DateFormatter.Style.none
        datefomatter.dateFormat = "MMM d, yyyy, hh:mm a zz"
        studentDOBTxt.text = datefomatter.string(from: sender.date)
        
    }

    @IBAction func saveStudentDetails(_ sender: UIButton) {
        
        let name = studentNameTxt.text
        let colleageName = studentSchoolNameTxt.text
        let DOB = studentDOBTxt.text
        let phoneNo = studentContactNoTxt.text
        let gender = genderTxt.text
        if (name!.isEmpty) || (colleageName!.isEmpty) || (DOB!.isEmpty) || (phoneNo!.isEmpty) || (gender!.isEmpty) || imageView.image == nil {
            
            displayayAlertMessage(messageToDisplay: "Enter all fields")
        }
        else {
            let isPhoneNoValidation = phoneNoValidation(phoneNo: phoneNo!)
            if isPhoneNoValidation {
                self.structureDetails()
            } else {
                displayayAlertMessage(messageToDisplay: "Contact field contain only number")
            }
        }
    }
    
    @IBAction func view(_ sender: UIButton) {
        
            performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let arr = uniqueElementsFrom(array: arrayOf)
            let viewcontroller = segue.destination as? DetailViewController
            viewcontroller?.studentDetailArray = arr
    }
    
    func uniqueElementsFrom(array: [studentList]) -> [studentList] {
        
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains("\($0)") else {
                return false
            }
            set.insert("\($0)")
            return true
        }
        return result 
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .lightGray
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text == studentNameTxt.text || textField.text == studentSchoolNameTxt.text {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.characters.count <= maxLength
        }
        
        if textField.text == studentContactNoTxt.text {
            
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.characters.count <= maxLength
        }
        return true
    }
    
    func structureDetails() {
        
       let myStudentDetails = studentList(name: studentNameTxt.text!, school: studentSchoolNameTxt.text!, contact: studentContactNoTxt.text!, DOB: studentDOBTxt.text!, gender: genderTxt.text!, image: imageView.image!)
        arrayOf.append(myStudentDetails)
        studentContactNoTxt.text = ""
        studentNameTxt.text = ""
        studentDOBTxt.text = ""
        studentSchoolNameTxt.text = ""
        genderTxt.text = ""
        imageView.image = UIImage(named: "")
        studentNameTxt.becomeFirstResponder()
    }
    
    private func phoneNoValidation (phoneNo: String) -> Bool {
        
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNo.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return phoneNo == filtered
    }
    
    func displayayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("OK Button Tapped")
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cameraBtn(_ sender: UIBarButtonItem) {
        
        let openMenu = UIAlertController(title: nil, message: "Choose Options", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "OpneCamera", style: .destructive) { (action: UIAlertAction!) in
            self.openCamera()
        }
        
        let photoLibrary = UIAlertAction(title: "OpenPhotoLibrary", style: .destructive) {(action: UIAlertAction!) in
            
            self.openPhotos()
        }
        
        openMenu.addAction(camera)
        openMenu.addAction(photoLibrary)
        present(openMenu, animated: true, completion: nil)
    }
    
    
    func openPhotos() {
        picker?.allowsEditing = false
        picker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            picker?.allowsEditing = false
            picker?.sourceType = UIImagePickerControllerSourceType.camera
            picker?.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        } else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chooseImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageViews = chooseImage
        imageView.image = imageViews
        dismiss(animated: true, completion: nil)
    }
}

