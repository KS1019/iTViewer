//
//  ViewController.swift
//  iTunesViewer
//
//  Created by Kotaro Suto on 2015/12/17.
//  Copyright © 2015年 Kotaro Suto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet var collectionViewOfApps: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataOfApps()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataOfApps(){
        let params = ["term":"Twitter", "country":"jp", "media":"software", "entity":"software", "limit":"25", "lang":"ja_jp"]
        Alamofire.request(.POST, "https://itunes.apple.com/search", parameters: params)
            .responseJSON{ response in
//                print("\(response.result.value)")
//                let json = JSON(response.result.value!)
//                if let trackName = json["results"][0]["trackName"].string {
//                    print(trackName)
//                }
//
    }

  }
}

