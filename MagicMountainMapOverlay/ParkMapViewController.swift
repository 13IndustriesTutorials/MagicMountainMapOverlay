//
//  ParkMapViewController.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import MapKit

class ParkMapViewController: UIViewController,MKMapViewDelegate
{

    var selectedOptions = String[]()
    var park:Park
    
    @IBOutlet var mapView : MKMapView
    
    init(coder aDecoder: NSCoder!)
    {
        self.park = Park(filename: "MagicMountain")
        super.init(coder: aDecoder)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        //determine the span of the latitude
        var latDelta = self.park.overlayTopLeftCoordinate.latitude - self.park.overlayBottomRightCoordinate.latitude

        //create the coordinate span
        var span = MKCoordinateSpanMake(fabs(latDelta),0.0)
        
        //create region
        var region = MKCoordinateRegionMake(self.park.midCoordinate,span)
        
        //set the maps region to the newly defined region
        self.mapView.region = region
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        
    }
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        var viewController = segue?.destinationViewController as MapOptionsViewController
        viewController.selectedOptions = self.selectedOptions
    }
    
    @IBAction func unwindFromOptions(segue: UIStoryboardSegue)
    {
        var viewController = segue.sourceViewController as MapOptionsViewController
        viewController.selectedOptions = self.selectedOptions
    }
    
    @IBAction func onMapViewChanged(sender : UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            self.mapView.mapType = MKMapType.Standard
        case 1:
            self.mapView.mapType = MKMapType.Hybrid
        case 2:
            self.mapView.mapType = MKMapType.Satellite
        default:
            self.mapView.mapType = MKMapType.Standard
        }
    }
    

}
