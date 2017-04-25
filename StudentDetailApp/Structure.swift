//
//  Structure.swift
//  StudentDetailApp
//
//  Created by raja A on 4/19/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

struct studentList {
    
    var studentName: String
    var studentSchoolName: String
    var studentContactNo: String
    var studentDOB: String
    var gender: String
    var sImage: UIImage
    
    init (name: String, school: String, contact: String, DOB: String, gender: String,image: UIImage) {
    
        self.studentName = name
        self.studentSchoolName = school
        self.studentContactNo = contact
        self.studentDOB = DOB
        self.gender = gender
        self.sImage = image
    }	
}

