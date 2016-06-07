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

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBAction func LogoutButtonTapped(sender: UIButton) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginPageNav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("profile page loaded")
        
        // makes my picture circular and sets border + border color
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        let myColor : UIColor = UIColor.blackColor()
        profileImage.layer.borderColor = myColor.CGColor
        profileImage.layer.borderWidth = 0.5
        
        // displays my image based on a Url
        let imageUrl = NSURL(string: profileUrl)
        
        if let url = imageUrl {
            profileImage.sd_setImageWithURL(url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

