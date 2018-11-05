//
//  PhotoCell.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/11/06.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class PhotoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    static var identifier: String {
        return self.className
    }
    static var nibName: String {
        return self.className
    }
}
