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
    }
    
    @IBAction func URLButton(){
        let urlOfAppStore = NSURL(string:(buttonOfAppStoreURL?.StringValue)!)
        let app:UIApplication = UIApplication.sharedApplication()
        print("urlOfAppStore -> \(urlOfAppStore)")
        app.openURL(urlOfAppStore!)
    }

    
}
