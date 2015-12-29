//
// VideosTableViewController.swift
// study_Moya
//
// Created by 宋立君 on 15/12/29.
// Copyright © 2015年 宋立君. All rights reserved.
//

import UIKit

class VideosTableViewController: UITableViewController {
	
	
	var repos = NSArray()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	
	
	/**
	 请求数据
	 */
	func loadData() {
		
		DSProvider.request(DS.GetVideosByType(0, 12, 0, 1)) {(result) -> () in
			
			switch result {
			
			case let .Success(response):
				do {
					let json: Dictionary? = try response.mapJSON() as? Dictionary<String, AnyObject>
					
					if let json = json {
						
//                        print(json)
						print(json["content"] as! Array<AnyObject>)
						
						if let contents: Array<AnyObject> = json["content"] as? Array<AnyObject> {
							self.repos = contents
						}
						
					}
					self.tableView.reloadData()
				} catch {
				}
			
			case let .Failure(error):
				print(error)
				break
			}
			
			
		}
		
		
		
	}
	
	/*
	 override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	 let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

	 // Configure the cell...

	 return cell
	 }
	 */
	
	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */
	
	/*
	 // Override to support editing the table view.
	 override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
	 if editingStyle == .Delete {
	 // Delete the row from the data source
	 tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
	 } else if editingStyle == .Insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */
	
	/*
	 // Override to support rearranging the table view.
	 override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

	 }
	 */
	
	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */
	
	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}


extension VideosTableViewController {
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
		
		// Configure the cell...
		
		let contentDic = repos[indexPath.row] as? Dictionary<String, AnyObject>
		
		cell.textLabel?.text = contentDic!["title"] as? String
		
		return cell
	}
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
	
	
}

