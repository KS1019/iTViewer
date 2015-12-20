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
    @IBOutlet var labelOfURL: UILabel!
    @IBOutlet var imageViewOfScreenShot: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
