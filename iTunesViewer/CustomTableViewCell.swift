//
//  CustomTableViewCell.swift
//  iTunesViewer
//
//  Created by Kotaro Suto on 2015/12/27.
//  Copyright © 2015年 Kotaro Suto. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet var labelOfAppName: UILabel!
    @IBOutlet var imageViewOfScreenShot: UIImageView!
    @IBOutlet var buttonOfAppStoreURL: KeepableValueButton?
    
    var label:UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        labelOfAppName = UILabel()
        imageViewOfScreenShot = UIImageView()
        buttonOfAppStoreURL = KeepableValueButton?()
        labelOfAppName = UILabel(frame: CGRectMake(0, 0, 100, 0))
        labelOfAppName.text = ""
//        labelOfAppName.sizeToFit()
//        labelOfAppName.backgroundColor = UIColor.grayColor()
//        labelOfAppName.alpha = 0.5
//        labelOfAppName.layer.cornerRadius = 3
//        labelOfAppName.clipsToBounds = true
    }
    
    @IBAction func URLButton(){
        let urlOfAppStore = NSURL(string:(buttonOfAppStoreURL?.StringValue)!)
        print("buttonOfAppStoreURL?.StringValue -> \(buttonOfAppStoreURL?.StringValue)")
        let app:UIApplication = UIApplication.sharedApplication()
        print("urlOfAppStore -> \(urlOfAppStore)")
        app.openURL(urlOfAppStore!)
    }

    
}
