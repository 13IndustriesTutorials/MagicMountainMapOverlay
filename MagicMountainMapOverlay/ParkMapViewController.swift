//
//  ParkMapViewController.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class ParkMapViewController: UIViewController
{

    var selectedOptions = String[]()
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
    
    @IBAction func unwindFromOptions(segue: UIStoryboardSegue?)
    {
        var viewController = segue?.sourceViewController as MapOptionsViewController
        viewController.selectedOptions = self.selectedOptions
    }

}
