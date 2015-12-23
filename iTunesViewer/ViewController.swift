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

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet var collectionViewOfApps: UICollectionView!
    
    var arrayOfAppName:[String] = []
    
    var itunesURL:NSMutableString = "http://appstore.com/"
    var appNameForURL = NSString()
    var arrayOfAppStoreURL:[String] = []
    
    var arrayOfURLOfScreenShot:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataOfApps()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCollectionView(){
        collectionViewOfApps.registerClass(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CellOfAppInformation")
        collectionViewOfApps.delegate = self
        collectionViewOfApps.dataSource = self

    }
    
    func getDataOfApps(){
        var titles: [String] = [ "A", "F", "G", "L" ]
        let index = (Int)(arc4random_uniform(4))
        print("title -> \(titles[index])")
        let params = ["term":titles[index], "country":"jp", "media":"software", "entity":"software", "limit":"10", "lang":"ja_jp"]
        Alamofire.request(.POST, "https://itunes.apple.com/search", parameters: params)
            .responseJSON{ response in
                print("\(response.result.value)")
                let json = JSON(response.result.value!)
                for resultOfRequest in json["results"].arrayValue{
                    
                    //AppNameを取得
                    if let appNameOfResult = resultOfRequest["trackName"].string{
                        print("appNameOfResult -> \(appNameOfResult)")
                        self.arrayOfAppName.append("\(appNameOfResult)")
                        print("arrayOfAppName -> \(self.arrayOfAppName)")
                    }
                    
                    //AppStoreのURLを取得
                    if let appURLOfResult = resultOfRequest["trackName"].string{
                        
                        let excludedStrings:[AnyObject] = ["!","¡","\"","#","$","%","'","(",")","*","+",",","\\","-",".","/",":",";","<","=",">","¿","?","@","[","\\","]","^","_","`","{","|","}","~"]
                        print("\(excludedStrings)")
                        for excludedString in excludedStrings {
                            if let locationOfExcludedString = appURLOfResult.rangeOfString("\(excludedString)"){
                                let str:NSMutableString = NSMutableString()
                                str.appendString(appURLOfResult)
                                print("\(str)")
                                str.deleteCharactersInRange(NSMakeRange(locationOfExcludedString.count, 1))
                                print("\(locationOfExcludedString.count)")
                                print("\(str)")
                                self.appNameForURL = str
                                print("appNameForURL -> \(self.appNameForURL)")
                            }
                        }
                        self.itunesURL = "http://appstore.com/"
                        self.itunesURL.appendString("\(self.appNameForURL)")
                        print("itunesURL -> \(self.itunesURL)")
                        self.arrayOfAppStoreURL.append("\(self.itunesURL)")
                        print("arrayOfAppStoreURL -> \(self.arrayOfAppStoreURL)")
                    }
                    
                    //スクリーンショットを取得
                    if let URLOfScreenShot = resultOfRequest["screenshotUrls"][0].string {
                        print("\(URLOfScreenShot)")
                        self.arrayOfURLOfScreenShot.append("\(URLOfScreenShot)")
                        print("\(self.arrayOfURLOfScreenShot)")
                    }
                }
        }
        let delay = 10.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            print( "5秒後の世界" )
            self.setCollectionView()
            
        })
    }
    
    
    
    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CellOfAppInformation", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        // TODO: Fix 
        //AppNameを表示
        cell.labelOfAppName.text = self.arrayOfAppName[indexPath.row]
        
        //スクリーンショットを表示
        let urlOfScreenShots = self.arrayOfURLOfScreenShot[indexPath.row]
        let req = NSURLRequest(URL:NSURL(string: urlOfScreenShots)!)
        NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
            let image = UIImage(data:data!)
            // 画像に対する処理 (UcellのUIImageViewに表示する等)
            cell.imageViewOfScreenShot.image = image
        }
        
        cell.buttonOfAppStoreURL?.StringValue = self.arrayOfAppStoreURL[indexPath.row]
        
        
        
        return cell
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    
}

