//
//  SideBarTableViewController.swift
//  BlurredSideBar
//
//  Created by Mavericks on 23/11/15.
//  Copyright © 2015 Mavericks. All rights reserved.
//

import UIKit

protocol SideBarTableViewControllerDelegate{
    func didSelectRow(indexPath:NSIndexPath)
}

class SideBarTableViewController: UITableViewController {

    var delegate: SideBarTableViewControllerDelegate?
    var menuData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?

        // Configure the cell...
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell?.backgroundColor = UIColor.clearColor()
            cell?.textLabel?.textColor = UIColor.darkTextColor()
            
            let selectedView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: (cell?.frame.size.width)!, height: (cell?.frame.size.height)!))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            
            cell?.selectedBackgroundView = selectedView
            
        }
        
        cell?.textLabel?.text = menuData[indexPath.row]

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.didSelectRow(indexPath)
    }
    


}
