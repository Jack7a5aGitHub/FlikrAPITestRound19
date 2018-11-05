//
//  PhotoSearchProvider.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class PhotoSearchProvider: NSObject {
    
    private var items = [Photo]()

    func getPhotoId(items: [Photo]) {
        if self.items.count >= 50 {
            self.items.append(contentsOf: items)
        } else {
        self.items = items
        }
    }
}

extension PhotoSearchProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let photoCell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            fatalError("Photo Cell is nil")
        }
        
        return photoCell
    }
    
}
