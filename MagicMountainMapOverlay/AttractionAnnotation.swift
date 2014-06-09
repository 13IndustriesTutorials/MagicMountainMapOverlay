//
//  AttractionAnnotation.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/8/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import MapKit

enum AttractionType
{
    case AttractionDefault
    case AttractionRide
    case AttractionFood
    case AttractionFirstAid
}

class AttractionAnnotation: NSObject, MKAnnotation
{
    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var type:AttractionType
    
    init()
    {
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.type = .AttractionDefault
    }
}
