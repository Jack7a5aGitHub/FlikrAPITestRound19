//
//  PhotoSearchTableViewCell.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

class PhotoSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var photoId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPhotoId(id: String) {
        photoId.text = id
    }

}
