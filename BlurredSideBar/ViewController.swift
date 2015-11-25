//
//  ViewController.swift
//  BlurredSideBar
//
//  Created by Mavericks on 23/11/15.
//  Copyright © 2015 Mavericks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideBarDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var sideBar: SideBar = SideBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let image: UIImage = UIImage(named: "image2")!
        //imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.contentMode = UIViewContentMode.ScaleToFill
        imageView.image = UIImage(CGImage: image.CGImage!, scale: 1.0, orientation: UIImageOrientation.Left)
        sideBar = SideBar(sourceView: self.view, menuItems: ["Red Color", "Tower Image", "NOT SET"])
        sideBar.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0 {
            imageView.backgroundColor = UIColor.redColor()
            imageView.image = nil
        }else if index == 1 {
            imageView.backgroundColor = UIColor.clearColor()
            let image: UIImage = UIImage(named: "image2")!
            //imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.contentMode = UIViewContentMode.ScaleToFill
            imageView.image = UIImage(CGImage: image.CGImage!, scale: 1.0, orientation: UIImageOrientation.Left)
            
        }
        
    }

}

