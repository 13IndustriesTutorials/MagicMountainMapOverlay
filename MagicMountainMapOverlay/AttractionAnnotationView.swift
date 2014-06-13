//
//  AttractionAnnotationView.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/8/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import MapKit


class AttractionAnnotationView: MKAnnotationView
{

    init(frame: CGRect)
    {
        super.init(frame: frame)
        // Initialization code
    }
    
    init(annotation: MKAnnotation!, reuseIdentifier: String!)
    {
        //call super initialier
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var attractionAnnotation:AttractionAnnotation = annotation as AttractionAnnotation
        
        switch attractionAnnotation.type
        {
        case .AttractionFirstAid:
            self.image = UIImage(named: "firstaid")
        case .AttractionRide:
            self.image = UIImage(named: "ride")
        case .AttractionFood:
            self.image = UIImage(named: "food")
        case .AttractionDefault:
            self.image = UIImage(named: "star")
        default:
            println()
            
        }
    }
}
