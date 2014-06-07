//
//  ParkMapOverlayView.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/6/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import MapKit


/* user MKOverlayRenderer instead of MKOverlayView as MKOverlayRenderer is deprecated in iOS 7*/

class ParkMapOverlayView: MKOverlayRenderer
{
    var overlayImage:UIImage

    init(overlay: MKOverlay!, overlayImage:UIImage)
    {
        self.overlayImage = overlayImage
        
        super.init(overlay: overlay)
    }
    
    
    override func drawMapRect(mapRect: MKMapRect, zoomScale zoomScale: MKZoomScale,
        inContext context: CGContext!)
    {
        let imageReference = self.overlayImage.CGImage
        let theMapRect = self.overlay.boundingMapRect
        let theRect =  self.rectForMapRect(theMapRect)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextTranslateCTM(context, 0.0, -theRect.size.height)
        CGContextDrawImage(context, theRect, imageReference)
    }

}
