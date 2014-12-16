//
//  ViewController.swift
//  SensorGraphs
//
//  Created by Theodor Brandt on 2014-12-16.
//  Copyright (c) 2014 Theodor Brandt. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, ChartDelegate {

    @IBOutlet var myChart: Chart!
    
    
    let motionManager: CMMotionManager = CMMotionManager()
    var accelX: Double = 0.0;
    var accelY: Double = 0.0;
    var accelZ: Double = 0.0;
    var kFilteringFactor: Double = 0.3;
    
    //var numbers = [Float]();
    
    var xAxisValue = [Float]();
    var yAxisValue = [Float]();
    var zAxisValue = [Float]();

    var xAxisSeries:ChartSeries!
    var yAxisSeries:ChartSeries!
    var zAxisSeries:ChartSeries!

    
    var sensor:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        
        myChart.minY = -1
        myChart.maxY = 1
    
        
        for(var i = 0; i < 30; i++){

            xAxisValue.append(Float(0));
            yAxisValue.append(Float(0));
            zAxisValue.append(Float(0));

        }
                
        xAxisSeries = ChartSeries(xAxisValue)
        yAxisSeries = ChartSeries(yAxisValue)
        zAxisSeries = ChartSeries(zAxisValue)
        
        xAxisSeries.color = ChartColors.greenColor()
        yAxisSeries.color = ChartColors.redColor()
        zAxisSeries.color = ChartColors.blueColor()

        myChart.addSeries(xAxisSeries)
        myChart.addSeries(yAxisSeries)
        myChart.addSeries(zAxisSeries)

        
        if(sensor == 0){
        self.motionManager.accelerometerUpdateInterval = 0.10;
        if motionManager.accelerometerAvailable{
            let queue = NSOperationQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:
                {(data: CMAccelerometerData!, error: NSError!) in
                    
                    //println("X = \(data.acceleration.x)")
                    //println("Y = \(data.acceleration.y)")
                    //println("Z = \(data.acceleration.z)")
                    
                
                    self.accelX = (data.acceleration.x * self.kFilteringFactor) + (self.accelX * (1.0 - self.kFilteringFactor));
                    self.accelY = (data.acceleration.y * self.kFilteringFactor) + (self.accelY * (1.0 - self.kFilteringFactor));
                    self.accelZ = (data.acceleration.z * self.kFilteringFactor) + (self.accelZ * (1.0 - self.kFilteringFactor));

                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.xAxis.text = "X: \(self.RadiansToDegrees(self.accelX))"
                        //self.yAxis.text = "Y: \(self.RadiansToDegrees(self.accelY))"
                        //self.zAxis.text = "Z: \(self.RadiansToDegrees(self.accelZ))"
                        
                        //self.placeLastAndMove(Float(self.accelX), axis: 0)
                        //self.placeLastAndMove(Float(self.accelX), axis: 0)
                        //self.placeLastAndMove(Float(self.accelX), axis: 0)

                        self.redrawGraph(Float(self.accelX), yAxis:Float(self.accelY),zAxis: Float(self.accelZ));
                        
                    });
                }
            )
        } else {
            println("Accelerometer is not available")
        }
        }
        
        
        if(sensor == 1){
            self.motionManager.gyroUpdateInterval = 0.10;
            if motionManager.gyroAvailable{
                let queue = NSOperationQueue()
                motionManager.startGyroUpdatesToQueue(queue, withHandler:
                    {(data: CMGyroData!, error: NSError!) in
                        
                        //println("X = \(data.acceleration.x)")
                        //println("Y = \(data.acceleration.y)")
                        //println("Z = \(data.acceleration.z)")
                        
                        
                        self.accelX = (data.rotationRate.x * self.kFilteringFactor) + (self.accelX * (1.0 - self.kFilteringFactor));
                        self.accelY = (data.rotationRate.y * self.kFilteringFactor) + (self.accelY * (1.0 - self.kFilteringFactor));
                        self.accelZ = (data.rotationRate.z * self.kFilteringFactor) + (self.accelZ * (1.0 - self.kFilteringFactor));
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            //self.xAxis.text = "X: \(self.RadiansToDegrees(self.accelX))"
                            //self.yAxis.text = "Y: \(self.RadiansToDegrees(self.accelY))"
                            //self.zAxis.text = "Z: \(self.RadiansToDegrees(self.accelZ))"
                            
                            //self.placeLastAndMove(Float(self.accelX), axis: 0)
                            //self.placeLastAndMove(Float(self.accelX), axis: 0)
                            //self.placeLastAndMove(Float(self.accelX), axis: 0)
                            
                            self.redrawGraph(Float(self.accelX), yAxis:Float(self.accelY),zAxis: Float(self.accelZ));
                            
                        });
                    }
                )
            } else {
                println("Accelerometer is not available")
            }
        }
        
        if(sensor == 2){
            self.motionManager.magnetometerUpdateInterval = 0.10;
            if motionManager.magnetometerAvailable{
                let queue = NSOperationQueue()
                motionManager.startMagnetometerUpdatesToQueue(queue, withHandler:
                    {(data: CMMagnetometerData!, error: NSError!) in
                        
                        //println("X = \(data.acceleration.x)")
                        //println("Y = \(data.acceleration.y)")
                        //println("Z = \(data.acceleration.z)")
                        
                        
                        self.accelX = (data.magneticField.x * self.kFilteringFactor) + (self.accelX * (1.0 - self.kFilteringFactor));
                        self.accelY = (data.magneticField.y * self.kFilteringFactor) + (self.accelY * (1.0 - self.kFilteringFactor));
                        self.accelZ = (data.magneticField.z * self.kFilteringFactor) + (self.accelZ * (1.0 - self.kFilteringFactor));
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            //self.xAxis.text = "X: \(self.RadiansToDegrees(self.accelX))"
                            //self.yAxis.text = "Y: \(self.RadiansToDegrees(self.accelY))"
                            //self.zAxis.text = "Z: \(self.RadiansToDegrees(self.accelZ))"
                            
                            //self.placeLastAndMove(Float(self.accelX), axis: 0)
                            //self.placeLastAndMove(Float(self.accelX), axis: 0)
                            //self.placeLastAndMove(Float(self.accelX), axis: 0)
                            
                            self.redrawGraph(Float(self.accelX), yAxis:Float(self.accelY),zAxis: Float(self.accelZ));
                            
                        });
                    }
                )
            } else {
                println("Accelerometer is not available")
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        self.motionManager.stopAccelerometerUpdates();
        self.motionManager.stopGyroUpdates();
        self.motionManager.stopMagnetometerUpdates();

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Chart delegate
    func didTouchChart(chart: Chart, indexes: Array<Int?>, x: Float, left: CGFloat) {
        // Do something on touch
    }
    
    func didFinishTouchingChart(chart: Chart) {
        // Do something when finished
    }

    
    
    func redrawGraph(xAxis:Float, yAxis:Float, zAxis:Float){

        self.myChart.removeSeries()

        self.xAxisValue.append(xAxis)
        if( self.xAxisValue.count >= 30){
            self.xAxisValue.removeAtIndex(0)
        }
        
        self.yAxisValue.append(yAxis)
        if( self.yAxisValue.count >= 30){
            self.yAxisValue.removeAtIndex(0)
        }
        
        self.zAxisValue.append(zAxis)
        if( self.zAxisValue.count >= 30){
            self.zAxisValue.removeAtIndex(0)
        }
    
        xAxisSeries = ChartSeries(xAxisValue)
        yAxisSeries = ChartSeries(yAxisValue)
        zAxisSeries = ChartSeries(zAxisValue)
        
        
        xAxisSeries.color = ChartColors.greenColor()
        yAxisSeries.color = ChartColors.redColor()
        zAxisSeries.color = ChartColors.blueColor()
        
        
        myChart.addSeries(xAxisSeries)
        myChart.addSeries(yAxisSeries)
        myChart.addSeries(zAxisSeries)

        self.myChart.setNeedsDisplay()

    
    }
    
    
    func placeLastAndMove(value:Float, axis:Int){
        
        
        self.myChart.removeSeries()
        
        
        self.xAxisValue.append(value)
        if( self.xAxisValue.count >= 30){
            self.xAxisValue.removeAtIndex(0)
        }
        
        //let series = ChartSeries(self.numbers)
        //series.color = ChartColors.greenColor()

        xAxisSeries = ChartSeries(xAxisValue)
        xAxisSeries.color = ChartColors.greenColor()

        
        self.myChart.addSeries(xAxisSeries)
        self.myChart.addSeries(yAxisSeries)
        self.myChart.addSeries(zAxisSeries)
        //self.myChart.addSeries(series)
        self.myChart.setNeedsDisplay()
    }
}

