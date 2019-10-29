//
//  restaurant.swift
//  HungryHoya
//
//  Created by jules on 5/1/19.
//  Copyright © 2019 Jules Comte. All rights reserved.
//
import UIKit
import MapKit

class restaurant: NSObject {
    
    var location: CLLocationCoordinate2D // the location of the restaurant
    var menu: String // the website of the restaurant's menu
    var hours: [[Double]] // the timetable of the restaurant
    var name : String // the name of the restaurant
    var standard : Bool // whether the menu is on hoyaeats.com
    
    init(location: CLLocationCoordinate2D, menu: String, hours: [[Double]], name: String, standard: Bool) {
        self.location = location
        self.menu = menu
        self.hours = hours
        self.name = name
        self.standard = standard
    } // init
    
    func isOpen(currentDay: Int, currentTime: Double) -> Bool {
        // checks whether this restaurant is currently open
        var i = 0
        var j = 1
        while j < hours[currentDay].count {
            if hours[currentDay][i] <= currentTime && hours[currentDay][j] >= currentTime {
                // if the current time is greater than the opening time and smaller than the closing time
                return true
            } // if
            i += 2
            j += 2 // advance the indexes to only look at pairs of open/close times
        } // while
        return false
    } // isOpen
} // restaurant
