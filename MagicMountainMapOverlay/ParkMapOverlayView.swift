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
    
    /* 
        it defines how this view is rendered when given a specific MKMapRect, MKZoomScale, and the CGContextRef 
        of the graphic context, with the intent to draw the overlay image onto the context at the appropriate scale.
    */
    override func drawMapRect(mapRect: MKMapRect, zoomScale zoomScale: MKZoomScale,
        inContext context: CGContext!)
    {
        
        //get the image, the map rect and set the overlay rect
        let imageReference = self.overlayImage.CGImage
        let theMapRect = self.overlay.boundingMapRect
        let theRect =  self.rectForMapRect(theMapRect)
        
        //Changes the scale of the user coordinate system in a context
        CGContextScaleCTM(context, 1.0, -1.0)
        
        //Changes the origin of the user coordinate system in a context
        CGContextTranslateCTM(context, 0.0, -theRect.size.height)
        
        //Draws an image into a graphics context
        CGContextDrawImage(context, theRect, imageReference)
    }

}
