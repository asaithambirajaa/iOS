//
//  DetailViewController.swift
//  StudentDetailApp
//
//  Created by raja A on 4/19/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var detailDataTable: UITableView!
    var studentDetailArray: [studentList] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return studentDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text =  studentDetailArray[indexPath.row].studentName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let indexPath: NSIndexPath = self.detailDataTable.indexPathForSelectedRow! as NSIndexPath
            let destViewController = segue.destination as! SecondTableViewController
            var secondTableArray: studentList
            secondTableArray = studentDetailArray[indexPath.row]
            destViewController.name = secondTableArray.studentName
            destViewController.contact = secondTableArray.studentContactNo
            destViewController.dob = secondTableArray.studentDOB
            destViewController.colleageName = secondTableArray.studentSchoolName
            destViewController.gender = secondTableArray.gender
            destViewController.myImage = secondTableArray.sImage
        }
    }
}
