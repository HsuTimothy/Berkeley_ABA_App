//
//  SecondViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/5/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import SDWebImage
import Firebase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var firstAndLastName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var objects: NSMutableArray! = NSMutableArray()
    
    @IBAction func LogoutButtonTapped(sender: UIButton) {
        
        if facebookLogin == false {
            do {
                nonFacebookFirstName = ""
                nonFacebookLastName = ""
            try FIRAuth.auth()?.signOut()
                let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                
                let loginPageNav = UINavigationController(rootViewController: loginPage)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = loginPageNav
            } catch is NSError {
                print("Error")
            }
        }
        else {
            print("IM HERE")
            facebookLogin = false
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        
            let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
            let loginPageNav = UINavigationController(rootViewController: loginPage)
        
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
            appDelegate.window?.rootViewController = loginPageNav
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("profile page loaded")
        
        // My table view
        self.objects.addObject("Report a bug")
        
        self.tableView.reloadData()
        
        // My logout button
        logoutButton.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        let myLogoutButtonColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        logoutButton.layer.borderColor = myLogoutButtonColor.CGColor
        logoutButton.layer.borderWidth = 0.5
        
        // makes my picture circular and sets border + border color
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        let myPictureColor : UIColor = UIColor.blackColor()
        profileImage.layer.borderColor = myPictureColor.CGColor
        profileImage.layer.borderWidth = 0.3
        
        // displays my image based on a Url
        if facebookLogin == true {
            let imageUrl = NSURL(string: profileUrl)
            if let url = imageUrl {
                profileImage.sd_setImageWithURL(url)
            }
        } else {
            let imageUrl = NSURL(string: "http://communities.naae.org/5.0.2/images/jive-profile-default-portrait.png")
            if let url = imageUrl {
                profileImage.sd_setImageWithURL(url)
            }
        }
        if facebookLogin {
            firstAndLastName.text! = facebookFirstName + " " + facebookLastName
        } else {
            firstAndLastName.text! = nonFacebookFirstName + " " + nonFacebookLastName
            // NON FACEBOOK FIRST AND LAST NAME HERE
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MY TABLE VIEW

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ProfilePageTableViewCell
        
        cell.labelTitle.text = self.objects.objectAtIndex(indexPath.row) as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("im here")
        self.performSegueWithIdentifier("showView", sender: self)
    }
}

