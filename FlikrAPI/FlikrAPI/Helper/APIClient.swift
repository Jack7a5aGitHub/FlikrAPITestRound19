//
//  APIClient.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Alamofire
import UIKit

enum Result {
    case success(Data?)
    case failure(Error)
}

final class APIClient {
    
    /// API Request
    static func request(router: Router,
                        completionHandler: @escaping (Result) -> Void = { _ in }) {
        
        Alamofire.request(router).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                fatalError("Status Code not yet setted")
            }
            LogHelper.log("http status code: \(String(describing: statusCode))")
            //LogHelper.log("Response: \(response)")
            
            switch response.result {
                
            case .success:
                LogHelper.log("\n👇👇👇" +
                    "\nStatusCode: \(String(describing: response.response?.statusCode))\nResponseBody: \(response)")
                completionHandler(Result.success(response.data))
                return
                
            case .failure:
                if let error = response.result.error {
                    LogHelper.log("\n🔻🔻🔻" +
                        "\nStatusCode: \nResponseBody:\(error)")
                    completionHandler(Result.failure(error))
                    return
                }
            }
        }
    }
}
