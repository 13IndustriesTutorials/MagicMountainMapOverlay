//
//  DetailViewController.swift
//  MagicMountainMapOverlay
//
//  Created by user on 6/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

protocol MapOptionsDelegate
{
    func didSelectOptions(options: String[])
}

class MapOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource 
{
    //declare instance variables
    var selectedOptions = String[]()
    var data = ["Park Boundary", "Map Overlay", "Attraction Pins", "Character Location", "Route" ]
    
    //declare the delegate for the options
    var delegate:MapOptionsDelegate?
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }


    //#pragma mark - Navigation    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    //#pragma mark
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var reuseIdentifier = "OptionCell"
        
        //dequeue a new cell for use in the table view
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        //set the cell text
        cell.textLabel.text = data[indexPath.row]
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView!,
        numberOfRowsInSection section: Int) -> Int
    {
        return self.data.count;
    }
    
    func tableView(tableView: UITableView!,
        didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        //get the cell by index path
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        
        
        if cell.accessoryType == UITableViewCellAccessoryType.None
        {
            //add a checkmark
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedOptions.append(cell.textLabel.text)
            
            //println("index path \(indexPath.row) count after add \(selectedOptions.count)")
            
        }
        else if cell.accessoryType == UITableViewCellAccessoryType.Checkmark
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            //find index of item in array, if present remove
            //use optional unbinding to test for nil and unwrap
            if let index = self.findIndex(cell.textLabel.text)
            {
                selectedOptions.removeAtIndex(index)
            }
        }
        
    }
    
    //find the array index of the item selected using optionals
    func findIndex(option:String)->Int?
    {
        //enumerate array using tuple to find value and index
        for(index, value) in enumerate(selectedOptions)
        {
            if value == option
            {
                return index
            }
        }
        return nil
    }
    

    @IBAction func onDoneButtonPressed(sender : UIBarButtonItem)
    {
        println("map options array \(self.selectedOptions)")
        //call the delegate method and pass the options array
        delegate?.didSelectOptions(self.selectedOptions)
        self.dismissModalViewControllerAnimated(true)
    }

}
