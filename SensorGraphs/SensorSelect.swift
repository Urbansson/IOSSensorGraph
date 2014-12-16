//
//  SensorSelect.swift
//  SensorGraphs
//
//  Created by Theodor Brandt on 2014-12-16.
//  Copyright (c) 2014 Theodor Brandt. All rights reserved.
//

import UIKit

class SensorSelect: UITableViewController, UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        
        var nib = UINib(nibName: "SelectSensorNode", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        
        self.tableView.reloadData()
        
    }
    
    
    override func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return 3;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:SelectSensorNode = self.tableView.dequeueReusableCellWithIdentifier("customCell") as SelectSensorNode
        
        // this is how you extract values from a tuple
        
        
        if(indexPath.item == 0){
        cell.loadItem("Accelerometer", deviceInfo: "")
        }
        
        if(indexPath.item == 1){
            cell.loadItem("Gyro", deviceInfo: "")
        }
        
        if(indexPath.item == 2){
            cell.loadItem("Magnetometer", deviceInfo: "")
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       

        self.performSegueWithIdentifier("showSensor", sender: indexPath.item)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Changing \((sender as Int))")
        
        if (segue.identifier == "showSensor") {
            let vc = segue.destinationViewController as ViewController
            vc.sensor = (sender as Int);
        }

    }
   
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
}
