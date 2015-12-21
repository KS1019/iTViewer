//
//  CustomCollectionViewCell.swift
//  iTunesViewer
//
//  Created by Kotaro Suto on 2015/12/18.
//  Copyright © 2015年 Kotaro Suto. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var labelOfAppName: UILabel!
    @IBOutlet var imageViewOfScreenShot: UIImageView!
    @IBOutlet var buttonOfAppStoreURL: KeepableValueButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    @IBAction func URLButton(){
        let urlOfAppStore = NSURL(string:(buttonOfAppStoreURL?.StringValue)!)
        let app:UIApplication = UIApplication.sharedApplication()
        app.openURL(urlOfAppStore!)
    }

}
