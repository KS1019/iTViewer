//
//  DetailsViewController.swift
//  iTunesViewer
//
//  Created by Kotaro Suto on 2016/01/03.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var selectedImg:UIImage? = UIImage()
    @IBOutlet var selectedImageView:UIImageView? = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView?.image = selectedImg

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
