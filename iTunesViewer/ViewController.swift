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
        //self.getDataOfApps()
        
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
    

    
    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        var titles: [String] = [ "A", "F", "G", "L" ]
        let index = (Int)(arc4random_uniform(4))
        print("\(titles[index])")
        let params = ["term":titles[index], "country":"jp", "media":"software", "entity":"software", "limit":"1", "lang":"ja_jp"]
        Alamofire.request(.POST, "https://itunes.apple.com/search", parameters: params)
            .responseJSON{ response in
                print("\(response.result.value)")
                let json = JSON(response.result.value!)
                cell.labelOfAppName.text = json["results"][0]["trackName"].string
                let url = NSURL(string:json["results"][0]["screenshotUrls"].string!)
                let req = NSURLRequest(URL:url!)
                
                NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
                    let image = UIImage(data:data!)
                    // 画像に対する処理 (UcellのUIImageViewに表示する等)
                    cell.imageViewOfScreenShot.image = image
                }

                
        }
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }

}

