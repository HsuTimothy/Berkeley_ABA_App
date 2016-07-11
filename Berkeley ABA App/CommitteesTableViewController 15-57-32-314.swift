//
//  CommitteesTableViewController.swift
//  Tab Example
//
//  Created by Timothy Hsu on 6/4/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import Foundation
import UIKit

class CommitteesTableViewController: UITableViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    let people = ["Officers", "Community Service", "Development", "Marketing", "Media Technology", "Professional", "Publications", "Social", "Special Activities", "Alumni"]
    var identities = [String]()
    
    override func viewDidLoad() {
        print("Events page loaded")
        
        // Deals with my image
        
        identities = ["Officers","Community Service","Development","Marketing","Media Technology","Professional","Publications","Social","Special Activities","Alumni"]
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel!.text = people[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Meet the ABA Family"
    }
}
