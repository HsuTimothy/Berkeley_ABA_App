//
//  PersonInformationViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/21/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit

class PersonInformationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    var tableViewList: NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Deals with the table view
        self.tableViewList.addObject("Email: " + individualEmail)
        self.tableViewList.addObject("Phone: " + individualPhoneNumber)
        
        self.tableView.reloadData()
        
        // Deals with the random white box
        
        // Deals with general individual info
        nameLabel.text = individualName
        
        positionLabel.text = individualPosition
        
        // Deals with the background color of the view controller
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        // Deals with the image
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        let myPictureColor : UIColor = UIColor.blackColor()
        imageView.layer.borderColor = myPictureColor.CGColor
        imageView.layer.borderWidth = 0.3
        
        // Deals with displaying the image
        let imageUrl = NSURL(string: individualImageURL)
        if let url = imageUrl {
            imageView.sd_setImageWithURL(url)
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.titleLabel.text = self.tableViewList.objectAtIndex(indexPath.row) as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Information"
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
