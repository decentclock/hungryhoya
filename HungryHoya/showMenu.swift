//
//  showMenu.swift
//  HungryHoya
//
//  Created by jules on 5/1/19.
//  Copyright © 2019 Jules Comte. All rights reserved.
//
import UIKit
import WebKit

class showMenu: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var currentPlace: restaurant!
    // this class will display the menu of this restaurant
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration) // set up the webView
        view = webView
        webView.navigationDelegate = self
    } // loadView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = createURL(url: currentPlace.menu)
        // format the url stored by this restaurant's object, see below for implementation
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Where Is It?", style: .plain, target: self, action: #selector(openTapped)) // set up a Where Is It button on the top right of the screen
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton] // set up a progress bar to show webpage loading progress at the bottom of the screen
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    } // viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isToolbarHidden = false // show the toolbar
    } // viewWillAppear
    
    @objc func openTapped() {
        performSegue(withIdentifier: "showMap", sender: navigationItem.rightBarButtonItem)
        // segue to show the location of the user and the restaurant
    } // openTapped
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = currentPlace.name // set the title of the view to the restaurant's name
    } // webView
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            // mirror the progress of the webpage loading to the progress of the bar at the bottom of the screen
        } // if
    } // observeValue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pointer = segue.destination as? showMap {
            pointer.currentPlace = currentPlace
            // pass this restaurant's along
        } // if
    } // prepare
    
    func createURL(url: String) -> URL {
        let date = Date() // returns today's date
        var formattedURL = url
        if (currentPlace.standard) {
            var dayNumber : String
            var monthNumber : String
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            if month < 10 {
                monthNumber = "0"+String(month)
            } else {
                monthNumber = String(month)
            }
            if day < 10 {
                dayNumber = "0" + String(day)
            } else {
                dayNumber = String(day)
            }
            formattedURL.append("?date="+String(year)+"-"+monthNumber+"-"+dayNumber)
            // the format that hoyaeats.com to set dates using the URL
        }
        return URL(string: formattedURL)!
    } // createURL
} // showMenu
