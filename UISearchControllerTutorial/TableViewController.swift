//
//  TableViewController.swift
//  UISearchControllerTutorial
//
//  Created by Hung Bui Van on 4/20/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var phones = [Phone]()

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
        return phones.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)
        cell.textLabel?.text = phones[indexPath.row].name
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToDetailVCSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailViewVC = segue.destinationViewController as! DetailViewController
                detailViewVC.phone = phones[indexPath.row]
            }
        }
    }
}
