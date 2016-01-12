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
    
    var arrayOfScreenShots:[UIImage?] = []
    
    var selectedImage: UIImage? = UIImage()
    
    let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataOfApps()
        
        self.tableViewOfApps.delegate = self
        self.tableViewOfApps.dataSource = self
        
        //tableViewOfApps.estimatedRowHeight = 90
        //tableViewOfApps.rowHeight = UITableViewAutomaticDimension
        
        //let myBoundSizeStr: NSString = "Bounds width: \(myBoundSize.width) height: \(myBoundSize.height)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        self.tableViewOfApps.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //
    }
    
    
    
    func getDataOfApps(){
        var titles: [String] = [ "A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        print("\(titles.count)")
        let index = (Int)(arc4random_uniform(26))
        print("title -> \(titles[index])")
        let params = ["term":titles[index], "country":"jp", "media":"software", "entity":"software", "limit":"20", "lang":"ja_jp"]
        
        arrayOfAppName = ["Twitter"]
        arrayOfAppStoreURL = ["http://appstore.com/Twitter"]
        arrayOfURLOfScreenShot = ["http://a2.mzstatic.com/jp/r30/Purple1/v4/c3/84/a9/c384a9fb-fb1b-5208-b6e8-cde6a2cde850/screen1136x1136.jpeg"]
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
        })
        
    }
    
    // MARK: -UITableViewController Delegate Protocol
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfAppName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! CustomTableViewCell
        
        //Labelをセット
        cell.labelOfAppName.text = arrayOfAppName[indexPath.row]
        cell.labelOfAppName.sizeToFit()
        cell.labelOfAppName.numberOfLines = 0
        cell.labelOfAppName.backgroundColor = UIColor.grayColor()
        cell.labelOfAppName.alpha = 0.6
        cell.labelOfAppName.layer.cornerRadius = 3
        cell.labelOfAppName.clipsToBounds = true
        
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
                cell.imageViewOfScreenShot?.image = image;
                self.arrayOfScreenShots.append(image)
            })
        })
        
        //cell.labelOfAppName.text = self.arrayOfAppName[indexPath.row]! as String
        print("\nAppName -> \(self.arrayOfAppName[indexPath.row]! as String)\nindexPath.row -> \(indexPath.row)\narrayOfAppStoreURL -> \(self.arrayOfAppStoreURL[indexPath.row])\nImageViewBoundsHeight -> \(cell.imageViewOfScreenShot.bounds.size.height)\nImageViewWidth -> \(cell.imageViewOfScreenShot.bounds.size.width)")
        
        return cell
    }
    
    @IBAction func refresh(){
        self.getDataOfApps()
        self.tableViewOfApps.reloadData()
    }
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        selectedImage = UIImage(named:"\(arrayOfScreenShots[indexPath.row])")
    //        if selectedImage != nil {
    //            // SubViewController へ遷移するために Segue を呼び出す
    //            performSegueWithIdentifier("toDetailsViewController",sender: nil)
    //        }
    //    }
    //
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    //        if (segue.identifier == "toDetailsViewController") {
    //            let subVC: DetailsViewController = (segue.destinationViewController as? DetailsViewController)!
    //            // SubViewController のselectedImgに選択された画像を設定する
    //            subVC.selectedImg! = selectedImage!
    //        }
    //    }
    
}

