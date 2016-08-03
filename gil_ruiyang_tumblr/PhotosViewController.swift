//
//  PhotosViewController.swift
//  gil_ruiyang_tumblr
//
//  Created by ruiyang_wu on 8/3/16.
//  Copyright © 2016 ruiyang_wu. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data: [NSDictionary]?
    var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var tableView: UITableView!
    
    func networkCall() {
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = NSURL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        print("url: \(url)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {
            (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                    print("response: \(responseDictionary)")
                    self.data = responseDictionary["response"]!["posts"] as? [NSDictionary]
                    print("\n\n\n")
                    print("AAA: ", self.data)
                    
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(PhotosViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl!, atIndex: 0) // not required when usi
        
        tableView.rowHeight = 320
        
        networkCall()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        let post = data![indexPath.row]
        print("PPP: ", post.valueForKeyPath("photos.original_size.url") as? [String])
        if let imageUrl = post.valueForKeyPath("photos.original_size.url") as? [String] {
        //if let imageUrl = post["photos"]!["original_size"]!!["url"]! {
            cell.photoView.setImageWithURL(NSURL(string: imageUrl[0])!)
            print("image loaded: ", imageUrl)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 100))
        //footerView.backgroundColor = UIColor.blackColor()
        //return footerView
        
        let headerView = UIView(frame: CGRectMake(0, 0, 320, 50))
        headerView.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRectMake(10, 10, 30, 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1
        
        let post = data![section]
        print("PPP: ", post.valueForKeyPath("photos.original_size.url") as? [String])
        if let imageUrl = post.valueForKeyPath("photos.original_size.url") as? [String] {
            profileView.setImageWithURL(NSURL(string: imageUrl[0])!)
            print("image loaded: ", imageUrl)
        }

        headerView.addSubview(profileView)
        
        
        return headerView
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0
    }

    func refresh(sender:AnyObject) {
        print("DDDDD")
        networkCall()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let photoDetailsViewController = segue.destinationViewController as! PhotoDetailsViewController
        let cell = sender as! PhotoCell
        let indexPath = tableView.indexPathForCell(cell)
        let post = data![indexPath!.row]
        if let imageUrl = post.valueForKeyPath("photos.original_size.url") as? [String] {
            cell.photoView.setImageWithURL(NSURL(string: imageUrl[0])!)
            print("image loaded: ", imageUrl[0])
            photoDetailsViewController.photoUrl = imageUrl[0]
            
        }
        
    }

}
