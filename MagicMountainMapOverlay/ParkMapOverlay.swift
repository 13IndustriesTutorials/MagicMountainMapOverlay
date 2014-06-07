//
//  ParkMapOverlay.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/6/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import MapKit

class ParkMapOverlay: NSObject, MKOverlay
{
   
    var boundingMapRect:MKMapRect
    var coordinate:CLLocationCoordinate2D
    
    init(park: Park)
    {
        boundingMapRect = park.overlayBoundingMapRect
        coordinate = park.midCoordinate
    }
}
