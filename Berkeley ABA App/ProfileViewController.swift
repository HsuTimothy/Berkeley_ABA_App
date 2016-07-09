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
import SafariServices

class ProfileViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var ReportABugButton: UIButton!
    @IBOutlet weak var VisitTheWebsiteButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var firstAndLastName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
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
        
        // My Credits button
        creditsButton.backgroundColor = UIColor.whiteColor()
        let myCreditsButtonColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        creditsButton.layer.borderColor = myVisitWebsiteButtonColor.CGColor
        creditsButton.layer.borderWidth = 0.5
        
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

    @IBAction func visitTheWebsiteButtonTapped(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "http://www.berkeleyaba.com")!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        // For future implementations if I want to do anything upon dismissal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

