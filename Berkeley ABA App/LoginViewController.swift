//
//  LoginViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/5/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit

var profileUrl = ""

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("login page loaded")
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            let parameters = ["fields":"email, first_name, last_name, picture.type(large)"]
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
                
                if error != nil {
                    print(error)
                    return
                }
                
                if let email = result["email"] as? String {
                    print(email)
                }
                if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                    print("picture at " + url)
                    profileUrl = url
                }
            }
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let iniitalViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Events1ViewController")
            appDelegate.window?.rootViewController = iniitalViewController
            appDelegate.window?.makeKeyAndVisible()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Completed login")
        fetchProfile()
    }
    
    func fetchProfile(){
        print("fetch profile")
        
        let parameters = ["fields":"email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if let email = result["email"] as? String {
                print(email)
            }
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                print("picture at " + url)
                profileUrl = url
            }
        }
        self.performSegueWithIdentifier("showNew", sender: self)
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
