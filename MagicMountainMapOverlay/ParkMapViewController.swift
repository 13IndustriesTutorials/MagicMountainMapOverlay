//
//  ParkMapViewController.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import MapKit

class ParkMapViewController: UIViewController, MKMapViewDelegate, MapOptionsDelegate
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


     override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.loadSelectedOptions()
    }
    
    
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        var viewController = segue?.destinationViewController as MapOptionsViewController
        viewController.selectedOptions = self.selectedOptions
        viewController.delegate = self //set the MapOptions delegate to this view controller
    }
    
    //create the overlay
    func addOverlay()
    {
        let overlay = ParkMapOverlay(park: self.park)
        self.mapView.addOverlay(overlay)
    }
    
    
    /*
     *
     */
    func loadSelectedOptions()
    {
        //remove all annotations and overlays to prevent duplications
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.removeOverlays(self.mapView.overlays)
        
        for (index, value)in enumerate(selectedOptions)
        {
            switch value
            {
            case "MapOverlay":
                self.addOverlay()
                
            default:
                break  //do nothing
            }
        }
    }
    
    //delegate method to show the overlay
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!
    {
        if overlay.isKindOfClass(ParkMapOverlay)
        {
            let magicMountainImage = UIImage(named: "overlay_park")
            let overlayView = ParkMapOverlayView(overlay: overlay, overlayImage: magicMountainImage)
            return overlayView
        }
        
        return nil
    }
    
    //implement the delegate callback method
    func didSelectOptions(options: String[])
    {
        self.selectedOptions = options
        println("selected options \(self.selectedOptions)")
    }

    
    /*
     *
     */
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
