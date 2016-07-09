//
//  CalendarViewController.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/11/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//
import GoogleAPIClient
import GTMOAuth2
import UIKit
import CoreLocation
import AddressBookUI

var individualEventlocation = ""
var individualRoomNumber = ""
var individualEventName = ""
var individualEventDate = ""
var individualEventTime = ""
var eventLatitude = 0.0
var eventLongitude = 0.0

class CalendarViewController: UITableViewController {
    
    var listOfEvents: [String] = []
    let sectionName = "Upcoming Events"
    
    private let kKeychainItemName = "Google Calendar API"
    private let kClientID = "536026404593-aqenhr7ig2hr6ruo85l47e0j8fgbb3tc.apps.googleusercontent.com"
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLAuthScopeCalendarReadonly]
    
    private let service = GTLServiceCalendar()
    let output = UITextView()
    
    // When the view loads, create necessary subviews
    // and initialize the Google Calendar API service
    override func viewDidLoad() {
        super.viewDidLoad()
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(
            kKeychainItemName,
            clientID: kClientID,
            clientSecret: nil) {
                service.authorizer = auth
        }
    }
    
    // When the view appears, ensure that the Google Calendar API service is authorized
    // and perform API calls
    override func viewDidAppear(animated: Bool) {
        if let authorizer = service.authorizer,
            canAuth = authorizer.canAuthorize where canAuth {
                listOfEvents.removeAll()
                fetchEvents()
        } else {
            presentViewController(
                createAuthController(),
                animated: true,
                completion: nil
            )
        }
    }
    
    // Construct a query and get a list of upcoming events from the user calendar
    func fetchEvents() {
        let query = GTLQueryCalendar.queryForEventsListWithCalendarId("primary")
        query.maxResults = 10
        query.timeMin = GTLDateTime(date: NSDate(), timeZone: NSTimeZone.localTimeZone())
        query.singleEvents = true
        query.orderBy = kGTLCalendarOrderByStartTime
        service.executeQuery(
            query,
            delegate: self,
            didFinishSelector: "displayResultWithTicket:finishedWithObject:error:"
        )
    }
    
    // Display the start dates and event summaries in the UITextView
    func displayResultWithTicket(
        ticket: GTLServiceTicket,
        finishedWithObject response : GTLCalendarEvents,
        error : NSError?) {
            
            if let error = error {
                showAlert("Error", message: error.localizedDescription)
                return
            }
            
            var eventString = ""
            
            if let events = response.items() where !events.isEmpty {
                for event in events as! [GTLCalendarEvent] {
                    let start : GTLDateTime! = event.start.dateTime ?? event.start.date
                    let startString = NSDateFormatter.localizedStringFromDate(
                        start.date,
                        dateStyle: .ShortStyle,
                        timeStyle: .ShortStyle
                    )
                    eventString += "\(startString) - \(event.summary)\n"
                    
                    // An array holding all my upcoming events
                    listOfEvents.append("\(startString) - \(event.summary)")
                }
            } else {
                eventString = "No upcoming events found."
            }
            output.text = eventString
            // PROBLEM: CAUSES TABLEVIEW TO CONTINUOUSLY GROW
            self.tableView.reloadData()
            
    }
    
    
    // Creates the auth controller for authorizing access to Google Calendar API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = scopes.joinWithSeparator(" ")
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: kClientID,
            clientSecret: nil,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: "viewController:finishedWithAuth:error:"
        )
    }
    
    // Handle completion of the authorization process, and update the Google Calendar API
    // with the new credentials.
    func viewController(vc : UIViewController,
        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
            
            if let error = error {
                service.authorizer = nil
                showAlert("Authentication Error", message: error.localizedDescription)
                return
            }
            
            service.authorizer = authResult
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil
        )
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.listOfEvents.count)
        return self.listOfEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("EventsCell", forIndexPath: indexPath) as UITableViewCell
        
        var event = ""
        event = listOfEvents[indexPath.row]
        
        cell.textLabel?.text = event
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionName
        }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Getting my event location
        let event = listOfEvents[indexPath.row]
        let eventArr = event.componentsSeparatedByString("|")
        let roomNumberWithSemicolon = eventArr[1]
        let locationWithSemicolon = eventArr[2]
        let roomNumber = roomNumberWithSemicolon.stringByReplacingOccurrencesOfString("|", withString: "")
        let location = locationWithSemicolon.stringByReplacingOccurrencesOfString("|", withString: "")
        let eventNameArray = eventArr[0].componentsSeparatedByString(" - ")
        var eventName = eventNameArray[1]
        eventName = eventName.stringByReplacingOccurrencesOfString(" - ", withString: "")
        individualEventName = eventName
        individualEventlocation = location
        individualRoomNumber = roomNumber
        let toGeocode = individualEventlocation + " Berkeley, CA"
        forwardGeocoding(toGeocode)
        
        // Getting the time and date of the event
        let eventTimeArr = eventArr[0].componentsSeparatedByString(",")
        let eventDate = eventTimeArr[0]
        var eventTime = eventTimeArr[1].stringByReplacingOccurrencesOfString(", ", withString: "")
        let eventTimeWithTitleArr = eventTime.componentsSeparatedByString(" - ")
        eventTime = eventTimeWithTitleArr[0]
        individualEventDate = eventDate
        individualEventTime = eventTime
        
        let vcName = "EventDetails"
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                eventLatitude = coordinate!.latitude
                eventLongitude = coordinate!.longitude
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                if placemark?.areasOfInterest?.count > 0 {
                    let areaOfInterest = placemark!.areasOfInterest![0]
                    print(areaOfInterest)
                } else {
                    print("No area of interest found.")
                }
            }
        })
    }
}