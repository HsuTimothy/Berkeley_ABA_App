//
//  LoginViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/5/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit
import Firebase

var profileUrl = ""
var facebookLogin = false
var facebookFirstName = ""
var facebookLastName = ""

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBAction func normalLoginButtonTapped(sender: AnyObject) {
        login()
    }
    
    func login() {
        FIRAuth.auth()?.signInWithEmail(usernameField.text!, password: passwordField.text!, completion: { user, error in
            if error != nil {
                print("incorrect username or password")
                let myAlert = UIAlertView(title: "Error", message: "Incorrect Password or Username", delegate: nil, cancelButtonTitle: "Ok")
                myAlert.show()
            }
            else {
                print("logged in no problem")
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let iniitalViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Events1ViewController")
                appDelegate.window?.rootViewController = iniitalViewController
                appDelegate.window?.makeKeyAndVisible()
            }
        })
    }
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("login page loaded")
        view.addSubview(loginButton)
        let theHeight = view.frame.size.height
        loginButton.frame = CGRect(x: 0, y: theHeight - 50 , width: self.view.frame.width, height: 50)
        loginButton.delegate = self
        
        
        if let _ = FBSDKAccessToken.currentAccessToken() {
            let parameters = ["fields":"email, first_name, last_name, picture.type(large)"]
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
                
                if error != nil {
                    print(error)
                    return
                }
                if let firstName = result["first_name"] as? String {
                    facebookFirstName = firstName
                    print(firstName)
                }
                if let lastName = result["last_name"] as? String {
                    facebookLastName = lastName
                    print(lastName)
                }
                if let email = result["email"] as? String {
                    print(email)
                }
                if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                    print("picture at " + url)
                    profileUrl = url
                }
            }
            facebookLogin = true
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
            if let firstName = result["first_name"] as? String {
                facebookFirstName = firstName
                print(firstName)
            }
            if let lastName = result["last_name"] as? String {
                facebookLastName = lastName
                print(lastName)
            }
            if let email = result["email"] as? String {
                print(email)
            }
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                print("picture at " + url)
                profileUrl = url
            }
        }
        facebookLogin = true
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
