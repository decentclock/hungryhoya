//
//  theList.swift
//  HungryHoya
//
//  Created by jules on 5/1/19.
//  Copyright © 2019 Jules Comte. All rights reserved.
//
// signed by Jules G Comte on 05/08/19 at 10.49
//
import UIKit
import MapKit

class theList: UITableViewController {
    
    var places: [restaurant] = Array.init()
    var openPlaces : [restaurant] = Array.init()
    var closedPlaces : [restaurant] = Array.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRestaurants() // Load the data
    } // viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isToolbarHidden = true
        sortRestaurants() // according to whether they are closed or open
        tableView.reloadData() // update the table accordingly
    } // viewWillAppear
    
    func sortRestaurants() {
        // Clear any data that might be in the two arrays
        openPlaces.removeAll()
        closedPlaces.removeAll()
        let date = Date() // Get today's date
        let calendar = Calendar.current // Get the current calendar
        var day = calendar.component(.weekday, from: date) // get the current weekday
        day = (day-2)%7 // convert the format of Apple to the one used here
        var hour: Double = Double(calendar.component(.hour, from: date)) // get the current hour
        let minutes: Double = Double(calendar.component(.minute, from: date)) // get the current minutes
        hour += minutes/100 // update the hour with the minutes
        for index in 0..<places.count {
            // for each of the restaurants, check whether they are open and
            // append them to the corresponding list
            if places[index].isOpen(currentDay: day, currentTime: hour) {
                openPlaces.append(places[index])
            } else {
                closedPlaces.append(places[index])
            } // else
        } // for
    } // sortRestaurants

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // one for open restaurants, one for others
    } // numberOfSections

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // open places list
            return openPlaces.count
        } else { // closed places list
            return closedPlaces.count
        } // else
    } // tableView
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { // open places list
            return "Open"
        } else { // closed places list
            return "Closed"
        } // else
    } // tableView

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var temp : restaurant
        if indexPath.section == 0 { // if filling up the open section, get it from openPlaces
            temp = openPlaces[indexPath.row]
        } else {
            temp = closedPlaces[indexPath.row] // otherwise, get it from the closedPlaces
            cell.selectionStyle = .none // disable any interaction with closed places
        }
        cell.textLabel?.text = temp.name // put the name of the restaurant as the label
        return cell
    } // tableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showMenu", sender: indexPath.row)
            // only segue if the user clicked on an open places
        } // if
    } // tableView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pointer = segue.destination as? showMenu {
            let index = sender as! Int
            pointer.currentPlace = openPlaces[index]
            // send the restaurant to the showMenu class to show its menu
        } // if
    } // prepare
    
    func loadRestaurants() {
        var hours : [[Double]] = Array.init()
        // temporary variable to store the time tables of each of the restaurants
        // Leo's
        hours.append([7.00,23.00]) // monday's open and closing times
        hours.append([7.00,23.00]) // tuesday
        hours.append([7.00,23.00]) // wednesday
        hours.append([7.00,23.00]) // thursday
        hours.append([7.00,20.00]) // friday
        hours.append([9.00,20.00]) // saturday
        hours.append([9.00,23.00]) // sunday
        var temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/fresh-food-company/", hours: hours, name: "Leo's", standard: true) // create the restaurant object
        places.append(temp) // append it to the list of restaurants
        hours.removeAll(keepingCapacity: false) // clear the temporary variable
        // Repeat for all the restaurants
        // Whisk
        hours.append([7.30,21.00])
        hours.append([7.30,21.00])
        hours.append([7.30,21.00])
        hours.append([7.30,21.00])
        hours.append([7.30,21.00])
        hours.append([8.30,14.00])
        hours.append([8.30,21.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/leo-mkt-whisk/", hours: hours, name: "Whisk", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Olive Branch
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,16.00])
        hours.append([1,0])
        // it is closed, make an interval such that isOpen will always yield false
        // see restaurant class for isOpen function
        hours.append([16.00,20.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/leo-mkt-olive-branch/", hours: hours, name: "Olive Branch", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Launch
        hours.append([11.00,15.00,16.30,19.30])
        hours.append([11.00,15.00,16.30,19.30])
        hours.append([11.00,15.00,16.30,19.30])
        hours.append([11.00,15.00,16.30,19.30])
        hours.append([11.00,14.30])
        hours.append([1,0])
        hours.append([1,0])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/leo-mkt-launch/", hours: hours, name: "Launch", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // 5Spice
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,16.00])
        hours.append([1,0])
        hours.append([16.00,20.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/leo-mkt-5spice/", hours: hours, name: "5Spice", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Sazon
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,16.00])
        hours.append([1,0])
        hours.append([16.00,20.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/leo-mkt-sazon/", hours: hours, name: "Sazón", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Bodega
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,16.00])
        hours.append([1,0])
        hours.append([16.00,20.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/leo-mkt-bodega/", hours: hours, name: "Bodega", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Einstein Bros Bagels
        hours.append([8.00,16.00])
        hours.append([8.00,16.00])
        hours.append([8.00,16.00])
        hours.append([8.00,16.00])
        hours.append([8.00,16.00])
        hours.append([1,0])
        hours.append([1,0])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.905857, longitude: -77.069924), menu: "https://www.einsteinbros.com/menu/", hours: hours, name: "Einstein Bros Bagels", standard: false)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Chik-fil-A
        hours.append([7.30,20.00])
        hours.append([7.30,20.00])
        hours.append([7.30,20.00])
        hours.append([7.30,20.00])
        hours.append([7.30,20.00])
        hours.append([11.00,16.00])
        hours.append([1,0])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.910458, longitude: -77.075284), menu: "https://www.chick-fil-a.com/", hours: hours, name: "Chik-fil-A", standard: false)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Crop Chop
        hours.append([11.00,19.00])
        hours.append([11.00,19.00])
        hours.append([11.00,19.00])
        hours.append([11.00,19.00])
        hours.append([11.00,19.00])
        hours.append([1,0])
        hours.append([1,0])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.910458, longitude: -77.075284), menu: "https://www.hoyaeats.com/locations/hoya-court-chop-chop/", hours: hours, name: "Crop Chop", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Royal Jacket
        hours.append([7.30,22.00])
        hours.append([7.30,22.00])
        hours.append([7.30,22.00])
        hours.append([7.30,22.00])
        hours.append([7.30,20.00])
        hours.append([11.00,20.00])
        hours.append([11.00,22.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.910249, longitude: -77.075030), menu: "https://www.hoyaeats.com/locations/royal-jacket-deli/", hours: hours, name: "Royal Jacket", standard: true)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        // Starbucks
        hours.append([6.30,21.00])
        hours.append([6.30,21.00])
        hours.append([6.30,21.00])
        hours.append([6.30,21.00])
        hours.append([6.30,16.00])
        hours.append([7.00,16.00])
        hours.append([7.00,16.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.909675, longitude: -77.074600), menu: "https://www.starbucks.com/menu", hours: hours, name: "Starbucks", standard: false)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        /*
        // POD Market
        hours.append([7.30,19.00])
        hours.append([7.30,19.00])
        hours.append([7.30,19.00])
        hours.append([7.30,19.00])
        hours.append([7.30,19.00])
        hours.append([1,0])
        hours.append([1,0])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906591, longitude: -77.074923), menu: "https://www.hoyaeats.com/locations/p-o-d-market/", hours: hours, name: "P.O.D Market")
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        */
        // Epicurean
        hours.append([6.30,24.00])
        hours.append([0.00,24.00])
        hours.append([0.00,24.00])
        hours.append([0.00,24.00])
        hours.append([0.00,24.00])
        hours.append([0.00,24.00])
        hours.append([0.00,22.30])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.911217, longitude: -77.073876), menu: "https://www.epicureanandcompany.com/menu/", hours: hours, name: "Epi", standard: false)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
        //Wisemiller's
        hours.append([7.00,23.30])
        hours.append([7.00,23.30])
        hours.append([7.00,23.30])
        hours.append([7.00,23.30])
        hours.append([7.00,23.30])
        hours.append([8.00,23.00])
        hours.append([8.00,23.00])
        temp = restaurant.init(location: CLLocationCoordinate2D.init(latitude: 38.906323, longitude: -77.070377), menu: "http://www.runinos.com/places/wisemillers-grocery-georgetown-dc/", hours: hours, name: "Wisemiller's", standard: false)
        places.append(temp)
        hours.removeAll(keepingCapacity: false)
    } // loadRestaurants
} // theList
