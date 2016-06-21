//
//  createAccountViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/6/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit
import Firebase

var nonFacebookFirstName = ""
var nonFacebookLastName = ""

// Create a reference to my Firebase location
let ref = FIRDatabase.database().reference()

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var retypedPassword: UITextField!
    @IBOutlet weak var desiredPassword: UITextField!
    @IBOutlet weak var desiredUsername: UITextField!
    
    @IBAction func createNewAccount(sender: UIButton) {
        if desiredPassword.text! != retypedPassword.text! {
            let myAlert = UIAlertView(title: "Error", message: "Passwords do not match", delegate: nil, cancelButtonTitle: "Ok")
            myAlert.show()
        } else if (desiredPassword.text!.characters.count == 0 && retypedPassword.text!.characters.count == 0) {
            let myAlert = UIAlertView(title: "Error", message: "Password cannot be blank", delegate: nil, cancelButtonTitle: "Ok")
            myAlert.show()
        } else if (desiredPassword.text!.characters.count <= 6) {
            let myAlert = UIAlertView(title: "Error", message: "Password must be at least 6 characters", delegate: nil, cancelButtonTitle: "Ok")
            myAlert.show()
        } else {
            if Reachability.isConnectedToNetwork() == true {
                print("Internet is okay")
                FIRAuth.auth()?.createUserWithEmail(desiredUsername.text!, password: desiredPassword.text!,     completion: { user, error in
                    if error != nil {
                        let myAlert = UIAlertView(title: "Alert", message: "Account already exists", delegate: nil, cancelButtonTitle: "Ok")
                        myAlert.show()
                    } else {
                        nonFacebookFirstName = self.firstName.text!
                        nonFacebookLastName = self.lastName.text!
                        
                        // Write data to my Firebase
                        // NOTE - PEOPLE WITH THE SAME FIRST AND LASTNAME WILL OVERRIDE EACH OTHER
                        let full_name = self.firstName.text! + " " + self.lastName.text!
                        let email = self.desiredUsername.text!
                        var newUser = [ "email": email, "full_name": full_name]
                        var usersRef = ref.childByAppendingPath("users")
                        var userKey = email.lowercaseString
                        userKey = userKey.stringByReplacingOccurrencesOfString(".", withString: ",")
                        var users = [userKey: newUser]
                        usersRef.setValue(users)
                        userIdentifier = self.desiredUsername.text!
                        userIdentifier = userIdentifier.lowercaseString
                        userIdentifier = userIdentifier.stringByReplacingOccurrencesOfString(".", withString: ",")
                        
                        self.login()
                    }
                })
            } else {
                print("Internet connection failed")
                let myAlert = UIAlertView(title: "Error", message: "No Internet Connection", delegate: nil, cancelButtonTitle: "Ok")
                myAlert.show()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login() {
        FIRAuth.auth()?.signInWithEmail(desiredUsername.text!, password: desiredPassword.text!, completion: { user, error in
            if error != nil {
                print("incorrect username or password")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
