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

class ViewController: UIViewController{
    
    //@IBOutlet var collectionViewOfApps: UICollectionView!


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
                print("\(response.result.value)")
                let json = JSON(response.result.value!)
                let locationOfExcludedString = json["results"][0]["trackName"].string?.rangeOfString("T")
                print(locationOfExcludedString)
                print(locationOfExcludedString?.count)
                if let trackName = json["results"][0]["trackName"].string {
                    print(trackName)
                }

                
            }
        }
    

    
    // MARK: - UICollectionViewDelegate Protocol
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCollectionViewCell
//        var titles: [String] = [ "A", "F", "G", "L" ]
//        let index = (Int)(arc4random_uniform(4))
//        print("\(titles[index])")
//        let params = ["term":titles[index], "country":"jp", "media":"software", "entity":"software", "limit":"1", "lang":"ja_jp"]
//        Alamofire.request(.POST, "https://itunes.apple.com/search", parameters: params)
//            .responseJSON{ response in
//                print("\(response.result.value)")
//                var json = JSON(response.result.value!)
//                
//                //AppNameを表示
//                cell.labelOfAppName.text = json["results"][0]["trackName"].string
//                
//                //スクリーンショットを表示
//                let urlOfScreenShots = NSURL(string:json["results"][0]["screenshotUrls"].string!)
//                let req = NSURLRequest(URL:urlOfScreenShots!)
//                NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
//                    let image = UIImage(data:data!)
//                    // 画像に対する処理 (UcellのUIImageViewに表示する等)
//                    cell.imageViewOfScreenShot.image = image
//                }
//                
//                //AppStoreのURLをセット
//                let itunesURL:String = "http://appstore.com/"
//                let excludedStrings:[AnyObject] = ["!","¡","\"","#","$","%","'","(",")","*","+",",","\\","-",".","/",":",";","<","=",">","¿","?","@","[","\\","]","^","_","`","{","|","}","~"]
//                print("\(excludedStrings)")
//                for excludedString in excludedStrings {
//                    if let locationOfExcludedString = json["results"][0]["trackName"].string?.rangeOfString("\(excludedString)"){
//                        var str = json["results"][0]["trackName"].string!
////                        str.deleteCharactersInRange(NSMakeRange(locationOfExcludedString, 1))
//                        print("\(locationOfExcludedString)")
//                        print("\(locationOfExcludedString.count)")
////                        str.removeAtIndex(locationOfExcludedString)
//                    }
//                }
//                
//                let urlOfAppStore = NSURL(string:itunesURL)
//                let app:UIApplication = UIApplication.sharedApplication()
//                app.openURL(urlOfAppStore!)
//                
//                
//        }
//        
//        return cell
//    }
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20;
//    }
    
}

