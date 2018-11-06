//
//  PhotoSearchDao.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Foundation
import Alamofire

struct PhotoSearch: Decodable {
    
    let photos: Photos
    
}

struct Photos: Decodable {
    let page: Int
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let server: String
    let title: String
    let farm: Int
    let secret: String
}

final class PhotoSearchDao {
    
    weak var returnResult: ReturnResult?
    
    func fetchPhoto(tags: String, page: Int) {
        
        if !NetworkConnection.isConnectable() {
            returnResult?.returnResult(returnCode: .offline)
            return
        }
        
        let parameter = ["method": "flickr.photos.search",
                    "api_key": "92f3fd8101d1d3a3613339d37c0452b9",
                    "format": "json",
                    "nojsoncallback": "1",
                    "tags": tags,
                    "per_page": 50,
                    "content_type": 1,
                    "media": "photos",
                    "privacy_filter": 1,
                    "page": page] as [String : Any]
        let router = Router.photoSearch(parameter)
        
        APIClient.request(router: router) { [weak self] response in
            
            switch response {
            case .success(let result):
                
                
                guard let data = result else {
                    print("no data ")
                    return
                }
              
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
             
                let fetchResult = try? decoder.decode(PhotoSearch.self, from: data)
             
                let photo = fetchResult?.photos.photo
                guard let fetchedPhoto = photo else { return }
                self?.returnResult?.returnResult(returnCode: .success(fetchedPhoto))
                print("fetch", fetchedPhoto)
            case .failure(let error):
                
                LogHelper.log("error_code: \((error as NSError).code)")
                LogHelper.log("error_description: \((error as NSError).description)")
                
                // ステータスに「エラー」を設定
                self?.returnResult?.returnResult(returnCode: .error(message: error.localizedDescription))
            }
        }
    }
}
