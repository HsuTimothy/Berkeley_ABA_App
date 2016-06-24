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

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var VisitTheWebsiteButton: UIButton!
    @IBOutlet weak var ReportABugButton: UIButton!
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
            try! FIRAuth.auth()!.signOut()
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
        
        // *MARK - An attempt to retrieve data but it doesn't seem to be working...
//        var userRef:FIRDatabaseReference!
//        userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            
//            if !snapshot.exists() {
//                print("none found")
//            }
//            
//            print(snapshot)
//            
//            if let userName = snapshot.value!["full_name"] as? String {
//                print(userName)
//            }
//            if let email = snapshot.value!["email"] as? String {
//                print(email)
//            }
//        
//             // can also use
//             // snapshot.childSnapshotForPath("full_name").value as! String
//        })
//        
//        ref.queryOrderedByChild("email").queryEqualToValue(userIdentifier).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//                if ( snapshot.value is NSNull ) {
//                    print("not found")
//                } else {
//                    for child in snapshot.children {
//                        let n = child.value!!["email"] as! String
//                        print(n)
//                    }
//                }
//            })
        // My viewcontroller's background color
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        // My report a bug button
        ReportABugButton.backgroundColor = UIColor.whiteColor()
        let myReportABugButtonColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        ReportABugButton.layer.borderColor = myReportABugButtonColor.CGColor
        ReportABugButton.layer.borderWidth = 0.5
        
        // My visit the website button
        VisitTheWebsiteButton.backgroundColor = UIColor.whiteColor()
        let myVisitWebsiteButtonColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        VisitTheWebsiteButton.layer.borderColor = myVisitWebsiteButtonColor.CGColor
        VisitTheWebsiteButton.layer.borderWidth = 0.5
        
        // My logout button
        logoutButton.backgroundColor = UIColor.whiteColor()
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
}

