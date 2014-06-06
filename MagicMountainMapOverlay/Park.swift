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
    //var name: String

    //create default initializer
    init(filename:String)
    {
        //this is temporary to prevent compilation errors
        overlayBottomRightCoordinate = CLLocationCoordinate2D(latitude: 0,longitude: 0)
        
        //name = "not assigned"

        //perform setup of object
        let thisBundle:NSBundle = NSBundle.mainBundle()

        let filePath:String = NSBundle.mainBundle().pathForResource("MagicMountain", ofType: "plist")

     
        //dictionary constructor name: value syntax
        let properties = NSDictionary(contentsOfFile: filePath)
   
        //extract the mid coordinate from the dictionary and convert to a CGPoint, then create
        //CLLocationCoordinate from point
        var midPoint = CGPointFromString(properties.valueForKey("midCoord") as String)
        self.midCoordinate = CLLocationCoordinate2DMake(midPoint.x, midPoint.y)
        
        //set top left
        var overlayTopLeftPoint = CGPointFromString(properties.valueForKey("overlayTopLeftCoord") as String)
        self.overlayTopLeftCoordinate = CLLocationCoordinate2DMake(overlayTopLeftPoint.x, overlayTopLeftPoint.y)
        
        
        //set top right
        var overlayTopRightPoint = CGPointFromString(properties.valueForKey("overlayTopRightCoord") as String)
        self.overlayTopRightCoordinate = CLLocationCoordinate2DMake(overlayTopRightPoint.x, overlayTopRightPoint.y)
        
        
        //set bottom left
        var overlayBottomLeftPoint = CGPointFromString(properties.valueForKey("overlayBottomLeftCoord") as String)
        self.overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(overlayBottomLeftPoint.x, overlayBottomLeftPoint.y)
        
        
        //calculate the bottom right corner
        self.overlayBottomRightCoordinate = CLLocationCoordinate2DMake(self.overlayBottomLeftCoordinate.latitude,self.overlayTopRightCoordinate.longitude)
        
        var boundaryPoints = NSArray(objects: properties.valueForKey("boundary"))
        
        self.boundaryPointsCount = boundaryPoints.count
        
        boundary = CLLocationCoordinate2D[]()
        
        for (index,coordinate : AnyObject) in enumerate(boundaryPoints)
        {
            var point = CGPointFromString(coordinate as String)
            self.boundary += CLLocationCoordinate2DMake(point.x, point.y)
        }
        
        
        var topLeft = MKMapPointForCoordinate(self.overlayTopLeftCoordinate);
        var topRight = MKMapPointForCoordinate(self.overlayTopRightCoordinate);
        var bottomLeft = MKMapPointForCoordinate(self.overlayBottomLeftCoordinate);
        var origin:MKMapPoint = MKMapPointMake(topLeft.x, topLeft.y)
        var size:MKMapSize = MKMapSizeMake(fabs(topLeft.x - topRight.x), fabs(topLeft.y - bottomLeft.y))
        
        self.overlayBoundingMapRect = MKMapRectMake(origin.x, origin.y, size.width, size.height)
        
        
        //call superclass initializer only after all variables have been initialized
        super.init()
    }


}
