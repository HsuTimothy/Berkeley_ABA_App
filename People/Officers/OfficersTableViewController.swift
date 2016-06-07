//
//  CommitteesTableViewController.swift
//  Tab Example
//
//  Created by Timothy Hsu on 6/4/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import Foundation
import UIKit

class OfficersTableViewController: UITableViewController {
    
    let people = ["Jason Wang - President", "Shadman Rahman - EVP", "Jasmine Li - IVP", "Ankit Bhatt - VPF", "Jo Jin Leong - VPO"]
    var identities = [String]()
    
    override func viewDidLoad() {
        print("Events page loaded")
        identities = ["Jason", "Shadman", "Jasmine", "Ankit", "Jo"]
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
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Committees and More"
    }
}
