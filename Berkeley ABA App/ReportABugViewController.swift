//
//  ReportABugViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/7/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.


import UIKit
import MessageUI

class ReportABugViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var Body: UITextView!
    @IBOutlet weak var labelTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let myBodyTextBorderColor : UIColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        Body.layer.borderColor = myBodyTextBorderColor.CGColor
        Body.layer.borderWidth = 1.0
        Body.layer.cornerRadius = 7 // CHANGE THIS TO MAKE IT ROUNDER
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Submits the bug report - *TO RECIPIENT WILL NOT SHOW UP ON XCODE SIMULATOR
    @IBAction func submitButtonTapped(sender: AnyObject) {
        print("Submit button tapped")
        
        let mailComposeViewController = configureMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        mailComposeVC.setToRecipients(["timothyhsu001@gmail.com"])
        mailComposeVC.setSubject("Berkeley ABA App Bug Report")
        mailComposeVC.setMessageBody(Body.text, isHTML: false)
        
        return mailComposeVC
    }
    
    func showSendMailErrorAlert() {
        let sendEmailAlert = UIAlertView(title: "Could not send email", message: "Your device could not send the e-mail. Check your Internet connection.", delegate: self, cancelButtonTitle: "Ok")
        sendEmailAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled Mail")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
