//
//  DetailViewController.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class MapOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    var data = ["Park Boundary", "Map Overlay", "Attractiopn Pins", "Character Location", "Route" ]

    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    //#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    //#pragma mark
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var reuseIdentifier = "OptionCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = data[indexPath.row]
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView!,
        numberOfRowsInSection section: Int) -> Int
    {
        return self.data.count;
    }
    
    @IBAction func onDoneButtonPressed(sender : AnyObject)
    {
        self.dismissModalViewControllerAnimated(true)
    }

}
