//
//  TableViewController.swift
//  UISearchControllerTutorial
//
//  Created by Hung Bui Van on 4/20/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var phones = [Phone]()
    
    var filteredPhones = [Phone]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phones = [
            Phone(category: "iPhone", name: "iPhone 5"),
            Phone(category: "iPhone", name: "iPhone 5s"),
            Phone(category: "iPhone", name: "iPhone 6"),
            Phone(category: "iPhone", name: "iPhone 6 plus"),
            Phone(category: "iPhone", name: "iPhone 6s"),
            Phone(category: "iPhone", name: "iPhone 6s plus"),
            Phone(category: "android", name: "galaxy note 4"),
            Phone(category: "android", name: "galaxy note 5"),
            Phone(category: "android", name: "galaxy s5"),
            Phone(category: "android", name: "galaxy s6"),
            Phone(category: "android", name: "galaxy s6 egde"),
            Phone(category: "android", name: "galaxy s7"),
            Phone(category: "android", name: "galaxy s7 egde"),
        ]
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.dimsBackgroundDuringPresentation = false
        // 3
        definesPresentationContext = true
        // 4
        tableView.tableHeaderView = searchController.searchBar
        // 5
        searchController.searchBar.barTintColor = UIColor(red: 52.0/255.0, green: 200.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        searchController.searchBar.tintColor = UIColor.whiteColor()
        
        searchController.searchBar.scopeButtonTitles = ["All", "iPhone", "android"]
        searchController.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredPhones.count
        }
        return phones.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)
        
        let phone: Phone
        if searchController.active && searchController.searchBar.text != "" {
            phone = filteredPhones[indexPath.row]
        } else {
            phone = phones[indexPath.row]
        }
        
        cell.textLabel?.text = phone.name
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredPhones = phones.filter { phone in
            let categoryMatch = (scope == "All") || (phone.category == scope)
            return categoryMatch && phone.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToDetailVCSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailViewVC = segue.destinationViewController as! DetailViewController
                let phone: Phone
                if searchController.active && searchController.searchBar.text != "" {
                    phone = filteredPhones[indexPath.row]
                } else {
                    phone = phones[indexPath.row]
                }
                
                detailViewVC.phone = phone
            }
        }
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
