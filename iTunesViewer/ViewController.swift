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

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var collectionViewOfApps: UICollectionView!
    @IBOutlet var tableViewOfApps:UITableView!
    
    var arrayOfAppName:[String?] = ["Twitter"]
    
    var itunesURL:NSMutableString = "http://appstore.com/"
    var appNameForURL = NSString()
    var arrayOfAppStoreURL:[String?] = ["http://appstore.com/Twitter"]
    
    var arrayOfURLOfScreenShot:[String?] = ["http://a2.mzstatic.com/jp/r30/Purple1/v4/c3/84/a9/c384a9fb-fb1b-5208-b6e8-cde6a2cde850/screen1136x1136.jpeg"]
    
    let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataOfApps()
        
        self.tableViewOfApps.delegate = self
        self.tableViewOfApps.dataSource = self
        
        tableViewOfApps.estimatedRowHeight = 90
        tableViewOfApps.rowHeight = UITableViewAutomaticDimension
        
        //let myBoundSizeStr: NSString = "Bounds width: \(myBoundSize.width) height: \(myBoundSize.height)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    
                    //スクリーンショットのURLを取得
                    if let URLOfScreenShot = resultOfRequest["screenshotUrls"][0].string {
                        print("URLOfScreenShot -> \(URLOfScreenShot)")
                        self.arrayOfURLOfScreenShot.append("\(URLOfScreenShot)")
                        print("arrayOfURLOfScreenShot -> \(self.arrayOfURLOfScreenShot) Count -> \(self.arrayOfURLOfScreenShot.count)")
                    }
                }
                
                print("reloadData")
                self.tableViewOfApps.reloadData()
                print("reloadedData \(self.tableViewOfApps)")
                
        }
        let delay = 5.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            print( "5秒後の世界" )
            //self.setCollectionView()
            
        })
        
    }
    
    // MARK: -UITableViewController Delegate Protocol
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfAppName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! CustomTableViewCell
        //スクリーンショットを表示
        let url:NSURL = NSURL(string:self.arrayOfURLOfScreenShot[indexPath.row]! as String)!
        let q_global: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        let q_main: dispatch_queue_t  = dispatch_get_main_queue();
        
        dispatch_async(q_global, {
            let imageURL: NSURL = url
            let imageData: NSData = NSData(contentsOfURL: imageURL)!
            let image: UIImage = UIImage(data: imageData)!
            
            dispatch_async(q_main, {
                let ratio = image.size.height / image.size.width
                print("\nratio -> \(ratio)")
                cell.imageViewOfScreenShot.bounds.size.width = self.myBoundSize.width
                cell.imageViewOfScreenShot.bounds.size.height =  self.myBoundSize.width * ratio
                cell.imageViewOfScreenShot?.image = image;
            })
        })
        
        //cell.labelOfAppName.text = self.arrayOfAppName[indexPath.row]! as String
        print("\nAppName -> \(self.arrayOfAppName[indexPath.row]! as String)\nindexPath.row -> \(indexPath.row)\narrayOfAppStoreURL -> \(self.arrayOfAppStoreURL[indexPath.row])\nImageViewBoundsHeight -> \(cell.imageViewOfScreenShot.bounds.size.height)\nImageViewWidth -> \(cell.imageViewOfScreenShot.bounds.size.width)")
        
        
        cell.layoutIfNeeded()
        return cell
    }
    
}

