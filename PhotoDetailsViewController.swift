//
//  PhotoDetailsViewController.swift
//  gil_ruiyang_tumblr
//
//  Created by ruiyang_wu on 8/3/16.
//  Copyright © 2016 ruiyang_wu. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoDetailsViewController: UIViewController {

    var photoUrl: String?
    @IBOutlet weak var photoView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("photourl.... \(photoUrl)")

        if let photoUrl = photoUrl {
            photoView.setImageWithURL(NSURL(string: photoUrl)!)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
