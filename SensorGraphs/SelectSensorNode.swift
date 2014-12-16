//
//  SelectSensorNode.swift
//  SensorGraphs
//
//  Created by Theodor Brandt on 2014-12-16.
//  Copyright (c) 2014 Theodor Brandt. All rights reserved.
//

//
//  SelectDeviceCell.swift
//  CoreBluetooth
//
//  Created by Theodor Brandt on 2014-12-14.
//  Copyright (c) 2014 Theodor Brandt. All rights reserved.
//

import Foundation
import UIKit

class SelectSensorNode: UITableViewCell {
    
    @IBOutlet var SensorName: UILabel!

    
    func loadItem(sensorName: String, deviceInfo: String) {
        self.SensorName.text = sensorName
    }
    
}