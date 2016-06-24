//
//  CommitteesTableViewController.swift
//  Tab Example
//
//  Created by Timothy Hsu on 6/4/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import Foundation
import UIKit

var individualEmail = ""
var individualName = ""
var individualPosition = ""
var individualImageURL = ""
var individualPhoneNumber = ""

class OfficersTableViewController: UITableViewController {
    
    let people = ["Jason Wang - President", "Shadman Rahman - EVP", "Jasmine Li - IVP", "Ankit Bhatt - VPF", "Jo Jin Leong - VPO"]
    let individual = "individual"
    var thisPersonList = [thisPerson]()
    
    override func viewDidLoad() {
        print("Events page loaded")
        self.thisPersonList = [thisPerson(name: "Jason Wang", email: "abapresident.berkeley@gmail.com", position: "President", imageURL : "https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/1598534_10207308677907926_96036650607996966_o.jpg", phoneNumber: "(678)650-7066"),
                               thisPerson(name: "Shadman Rahman", email: "abaexternal@gmail.com", position: "External Vice President", imageURL: "https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/13113000_1103362049686337_8272495080709891781_o.jpg", phoneNumber: "(805)444-6595"),
                               thisPerson(name: "Jasmine Li", email: "abainternalvp@gmail.com", position: "Internal Vice President", imageURL: "https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/12489318_874132969365958_5895703395665659543_o.jpg", phoneNumber: "(626)623-0225"),
                               thisPerson(name: "Ankit Bhatt", email: "abavpfinance@gmail.com", position: "Vice President of Finance", imageURL: "https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/12615600_10207391518158909_2739395774026765306_o.jpg", phoneNumber: "(510)207-4836"),
                               thisPerson(name: "Jo Jin Leong", email: "abavpoperations@gmail.com", position: "Vice President of Operations", imageURL: "https://scontent.fsnc1-1.fna.fbcdn.net/v/t1.0-9/11960059_10207688353187747_5821659518334783909_n.jpg?oh=b06aa79715eac3b7b3ec4e32b0e13138&oe=58021D40", phoneNumber: "(510)283-4827")]
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OfficersCell")
        cell?.textLabel!.text = people[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let whichPerson = thisPersonList[indexPath.row]
        // MAKE EMAIL = THIS PERSON'S EMAIL
        individualEmail = whichPerson.email
        individualName = whichPerson.name
        individualPosition = whichPerson.position
        individualImageURL = whichPerson.imageURL
        individualPhoneNumber = whichPerson.phoneNumber
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(individual)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Officers"
    }
}
