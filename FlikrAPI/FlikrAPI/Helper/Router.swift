//
//  Router.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Alamofire

enum Method: String {
    
    case search = "flickr.photos.search"
    
}

enum Router: URLRequestConvertible {
    
    
    static let baseURLString = "https://api.flickr.com/services/rest/"
    
    case photoSearch([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, para): (String, String, [String: Any]) = {
            
            switch self {
            case .photoSearch(let paras):
                return ("GET","", paras)
         
            }
        }()
        
        if let url = URL(string: Router.baseURLString) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method
            //urlRequest.allHTTPHeaderFields = header
            
            LogHelper.log("\(urlRequest)")
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: para)
        } else {
            fatalError("url is nil.")
        }
    }
}

