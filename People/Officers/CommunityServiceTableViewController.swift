//
//  CommunityServiceTableViewController.swift
//  
//
//  Created by Timothy Hsu on 6/24/16.
//
//

import UIKit

class CommunityServiceTableViewController: UITableViewController {
    var membersInCS = ["Nicholas Truong - Chair", "Katherine Luo - Chair"]
    var thisPersonList = [thisPerson]()
    let positionList = ["Chairs", "Committee Members"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.thisPersonList = [thisPerson(name: "Nicholas Truong", email: "Nstruong13@berkeley.edu", position: "Community Service Chair", imageURL : "https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/12491778_10204045905267443_5182610452331869983_o.jpg", phoneNumber: "(626) 589-4237"), thisPerson(name: "Katherine Luo", email: "kmluo@berkeley.edu", position: "Community Service Chair", imageURL: "https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/13301374_10205714297165943_2874164404920578513_o.jpg", phoneNumber: "(###) ###-####")]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return membersInCS.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Community Service Cell")
        cell?.textLabel!.text = membersInCS[indexPath.row]

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let whichPerson = thisPersonList[indexPath.row]
        
        individualEmail = whichPerson.email
        individualName = whichPerson.name
        individualPosition = whichPerson.position
        individualImageURL = whichPerson.imageURL
        individualPhoneNumber = whichPerson.phoneNumber
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("individual")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Community Service"
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
