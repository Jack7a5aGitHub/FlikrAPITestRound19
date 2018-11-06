//
//  PhotoCell.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/11/06.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit
import Kingfisher

final class PhotoCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoTitleLabel: UILabel!
    var photoId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static var identifier: String {
        return self.className
    }
    static var nibName: String {
        return self.className
    }
    var title: String = "" {
        didSet {
            photoTitleLabel.text = title
        }
    }
    var imageUrl: String = "" {
        didSet {
            guard let baseUrl = URL(string: imageUrl) else {
                return
            }
            print("url", baseUrl)
            photoImageView.kf.setImage(with: baseUrl)
        }
    }
}
