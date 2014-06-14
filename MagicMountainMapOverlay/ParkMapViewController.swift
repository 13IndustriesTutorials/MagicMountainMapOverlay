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

        //set the delegate for the map view
        self.mapView.delegate =  self
        
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
        let overlay = ParkMapOverlay(park:self.park)
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
            case "Map Overlay":
                self.addOverlay()
            case "Attraction Pins":
                self.addingAttrationsPins()
            case "Route":
                self.addRoute()
            case "Park Boundary":
                self.addBoundary()
            case "Character Location":
                self.addCharacterLocations()
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
        else if overlay.isKindOfClass(MKPolyline)
        {
            var lineview = MKPolylineRenderer(overlay: overlay)
            lineview.strokeColor = UIColor.greenColor()
            return lineview
        }
        else if overlay.isKindOfClass(MKPolygon)
        {
            var polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.magentaColor()
            return polygonView
        }
        else if overlay.isKindOfClass(MKCircle)
        {
            var characterView = MKCircleRenderer(overlay: overlay)
            characterView.strokeColor = (overlay as Character).color
            return characterView
        }
        
        return nil
    }
    
    //delegate method to add annotation
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
    {
        var annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    //implement the delegate callback method
    func didSelectOptions(options: String[])
    {
        self.selectedOptions = options
        println("selected options \(self.selectedOptions)")
    }
    
    /*
     * Create custom pin annotations for displaying the park attractions on the map. Each
     * pin annotation has a callout view with attraction specific information
     */
    func addingAttrationsPins()
    {
        
        //@"file:///Users/user/Library/Developer/CoreSimulator/Devices/CF6083CE-3851-4964-89EF-7B3F7E4A6E85/data/Containers/Bundle/Application/EF306FC1-9C6C-48A2-B4EC-943395330865/MagicMountainMapOverlay.app/MagicMountainAttractions.plist
        var filePath = NSBundle.mainBundle().URLForResource("MagicMountainAttractions", withExtension: "plist")
        var attractions = NSArray(contentsOfURL: filePath)
        
        for attraction:AnyObject in attractions
        {
            var location = attraction as NSDictionary
            var point = CGPointFromString(location.valueForKey("location") as String)
            //println("point is \(point)")
            var annotation = AttractionAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: point.x, longitude: point.y)
            //println("coordinate is \(annotation.coordinate)")
            annotation.title = location.valueForKey("name")as? String
            //println("title is \(annotation.title)")
            annotation.subtitle = location.valueForKey("subtitle") as? String
            //println("subtitle is \(annotation.subtitle)")
            
            var type = location.valueForKey("type") as String
            //println("type is \(type)")
            
            switch (type)
                {
            case "0":
                annotation.type = .AttractionDefault
            case "1":
                annotation.type = .AttractionRide
            case "2":
                annotation.type = .AttractionFood
            case "3":
                annotation.type = .AttractionFirstAid
            default:
                annotation.type = .AttractionFirstAid
            }
            
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func addCharacterLocations()
    {
        var characterLocation = self.extractPointsFromFile("BatmanLocations")
        var index:Int = 0
        var batmanLocation = CGPointFromString(characterLocation.objectAtIndex(index) as String)
        var batman = Character(centerCoordinate: CLLocationCoordinate2DMake(batmanLocation.x, batmanLocation.y), radius: 50.0)
        batman.color = UIColor.blueColor()
        
        characterLocation = self.extractPointsFromFile("TazLocations")
        var tazLocation = CGPointFromString(characterLocation.objectAtIndex(index) as String)
        var taz = Character(centerCoordinate: CLLocationCoordinate2DMake(tazLocation.x, tazLocation.y), radius: 30.0)
        taz.color = UIColor.orangeColor()
        
        characterLocation = self.extractPointsFromFile("TweetyBirdLocations")
        var tweetyLocation = CGPointFromString(characterLocation.objectAtIndex(index) as String)
        var tweety = Character(centerCoordinate: CLLocationCoordinate2DMake(tweetyLocation.x, tweetyLocation.y), radius: 15.0)
        tweety.color = UIColor.yellowColor()
        
        
        self.mapView.addOverlay(batman)
        self.mapView.addOverlay(taz)
        self.mapView.addOverlay(tweety)
        
    }
    
    func extractPointsFromFile(fileName:String)->NSArray
    {
        var path  = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist")
        var points = NSArray(contentsOfFile: path);
        return points
    }

    /*
     * Draw a route from the entrance of the park to the ride Goliath using MKPolyline
     */
    func addRoute()
    {
        var path  = NSBundle.mainBundle().pathForResource("EntranceToGoliathRoute", ofType: "plist")
        var points = NSArray(contentsOfFile: path);
        var pointsCount = points.count;
        var pointsToUse = CLLocationCoordinate2D[]();
        
        for (index, value:AnyObject)in enumerate(points)
        {
            var p = CGPointFromString(value as String);
            pointsToUse += CLLocationCoordinate2DMake(p.x, p.y)
        }
        
        var polyline = MKPolyline(coordinates: &pointsToUse, count: pointsToUse.count)
        self.mapView.addOverlay(polyline)
    }
    
    
   /*
    * Add a MKPolygon to map view to represent the boundary of the park
    */
    func addBoundary()
    {
        var boundary = MKPolygon(coordinates: &self.park.boundary, count: self.park.boundary.count)
        self.mapView.addOverlay(boundary)
    }
    
    
    /*
     * Change the map view based on the selected segement
     * @param UISegmentedControl sender
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
