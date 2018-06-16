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
        self.items = items
    }
    
}

extension PhotoSearchProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of Rows Count: \(items.count)")
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoSearchTableViewCell else {
            fatalError("Photo Cell is nil")
        }
        
        cell.setPhotoId(id: items[indexPath.row].id)
  
        return cell
    }
    
}
