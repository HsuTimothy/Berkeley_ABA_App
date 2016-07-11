//
//  EventDetailsViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 7/8/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit


class EventDetailsViewController: UIViewController {
    @IBOutlet weak var callForHelpButton: UIButton!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLocation.text = individualEventlocation
        eventName.text = individualEventName
        eventDateLabel.text = individualEventDate
        eventTimeLabel.text = individualEventTime
        
        // Deals with the top image (Campinele)
        self.view.sendSubviewToBack(image1)
        image1.alpha = 0.5
        
        // Deals with the call for directions button
        let myCallForHelpButtonBorderColor : UIColor = UIColor.blackColor()
        let myCallForHelpButtonBGColor : UIColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        callForHelpButton.layer.backgroundColor = myCallForHelpButtonBGColor.CGColor
        callForHelpButton.layer.cornerRadius = 3
        callForHelpButton.layer.borderColor = myCallForHelpButtonBorderColor.CGColor
        callForHelpButton.layer.borderWidth = 0.06
    }
    
    // MAKES THE PHONE CALL
    @IBAction func makePhoneCall(sender: AnyObject) {
        if let url = NSURL(string: "tel://16786507066") { // CHANGE PHONE NUMBER HERE [THIS IS JASON'S #]
            UIApplication.sharedApplication().openURL(url)
        }
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
