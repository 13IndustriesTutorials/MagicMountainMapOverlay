//
//  Park.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/5/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class Park: NSObject
{
    
    //declare class variables
    var boundary:Array<CLLocationCoordinate2D>
    var boundaryPointsCount: Int
    var midCoordinate: CLLocationCoordinate2D
    var overlayTopLeftCoordinate: CLLocationCoordinate2D
    var overlayTopRightCoordinate: CLLocationCoordinate2D
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D
    var overlayBottomRightCoordinate: CLLocationCoordinate2D
    var overlayBoundingMapRect:MKMapRect
    
    //create default initializer
    init(filename:String)
    {
        //perform setup of object
        //let thisBundle:NSBundle = NSBundle.mainBundle()

        
        //
        //let fileURL = NSBundle.mainBundle().URLForResource("MagicMountain", withExtension: "plist")
        
        
        //this method does not return a correct value for some undetermined reason
        //let filePath:String = NSBundle.mainBundle().pathForResource("MagicMountain", ofType: "plist")
     
        //dictionary constructor name: value syntax
        let properties:NSDictionary = NSDictionary(contentsOfFile: "//Users/user/Library/Developer/CoreSimulator/Devices/CF6083CE-3851-4964-89EF-7B3F7E4A6E85/data/Containers/Bundle/Application/EF306FC1-9C6C-48A2-B4EC-943395330865/MagicMountainMapOverlay.app/MagicMountain.plist")
        
        //let properties = NSDictionary(contentsOfURL: fileURL)
        
        
        //extract the mid coordinate from the dictionary and convert to a CGPoint, then create CLLocationCoordinate from point
        let midPoint = CGPointFromString(properties.valueForKey("midCoord") as String)
        self.midCoordinate = CLLocationCoordinate2DMake(midPoint.x, midPoint.y)
        
        //set top left
        let overlayTopLeftPoint = CGPointFromString(properties.valueForKey("overlayTopLeftCoord") as String)
        self.overlayTopLeftCoordinate = CLLocationCoordinate2DMake(overlayTopLeftPoint.x, overlayTopLeftPoint.y)
        
        
        //set top right
        let overlayTopRightPoint = CGPointFromString(properties.valueForKey("overlayTopRightCoord") as String)
        self.overlayTopRightCoordinate = CLLocationCoordinate2DMake(overlayTopRightPoint.x, overlayTopRightPoint.y)
        
        
        //set bottom left
        let overlayBottomLeftPoint = CGPointFromString(properties.valueForKey("overlayBottomLeftCoord") as String)
        self.overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(overlayBottomLeftPoint.x, overlayBottomLeftPoint.y)
        
        
        //calculate the bottom right corner
        self.overlayBottomRightCoordinate = CLLocationCoordinate2DMake(self.overlayBottomLeftCoordinate.latitude,self.overlayTopRightCoordinate.longitude)
        
        //extract boundary data from plist file and convert to array of strings, we need to cast as NSArray
        var boundaryPoints = properties.objectForKey("boundary") as NSArray

        //set the number of boundary points
        self.boundaryPointsCount = boundaryPoints.count
        
        //initialize the array to an empy array
        boundary = CLLocationCoordinate2D[]()
        
        //create a point from each boundary entry and add to array
        for (index, point:AnyObject) in enumerate(boundaryPoints)
        {
            //println("point \(point)")
            let myPoint:CGPoint = CGPointFromString(point as String)
            //println("myPoint \(myPoint)")
            self.boundary += CLLocationCoordinate2DMake(myPoint.x, myPoint.y)
        }
        
        
        var topLeft = MKMapPointForCoordinate(self.overlayTopLeftCoordinate);
        var topRight = MKMapPointForCoordinate(self.overlayTopRightCoordinate);
        var bottomLeft = MKMapPointForCoordinate(self.overlayBottomLeftCoordinate);
        
        //create MKMapPoint and MKMapSize objects to resolve compile errors caused by using MKMapPoint type directly
        var origin:MKMapPoint = MKMapPointMake(topLeft.x, topLeft.y)
        var size:MKMapSize = MKMapSizeMake(fabs(topLeft.x - topRight.x), fabs(topLeft.y - bottomLeft.y))
        
        //create overlay rectangle
        self.overlayBoundingMapRect = MKMapRectMake(origin.x, origin.y, size.width, size.height)
        
        
        //call superclass initializer only after all variables have been initialized
        super.init()
    }


}
