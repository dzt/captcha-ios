//
//  Request.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Request {
    
    private static var baseURL = "http://127.0.0.1:8080"
    
    class func request(_ endpoint: String, requestType: String = "GET", headers: [String: String] = [String: String](), params: [String: String] = [String: String](), body: Any? = nil, completion: ((_ json: JSON?, _ error: String?) -> Void)?) {
        Request.dataRequest("\(baseURL)\(endpoint)", requestType: requestType, headers: headers, params: params, body: body) { (data, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            let json = JSON(data: data)
            completion?(json, error)
        }
    }
    
    class func dataRequest(_ baseURL: String, requestType: String = "GET", headers: [String: String] = [String: String](), params: [String: String] = [String: String](), body: Any? = nil, completion: ((_ data: Data?, _ error: String?) -> Void)?) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache = nil
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        var url = URL(string: baseURL)!
        url = URLByAppendingQueryParameters(url, queryParameters: params)
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        
        if let body = body {
            do {
                request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                completion?(nil, "An unknown error occurred 1")
                return
            }
        }
        
        for (header, val) in headers {
            request.addValue(val, forHTTPHeaderField: header)
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion?(nil, "Unknown Error has Occured 2")
                return
            }
            
            let json = JSON(data: data)
            var requestError: String
            
            if let error = error {
                switch error._code {
                case -1009: requestError = "Offline"
                default: break
                }
                
                completion?(nil, "An Error has occured 3")
            } else if response.statusCode != 200 && response.statusCode != 204 {
                switch response.statusCode {
                case 400:
                    if let message = json["message"].string {
                        requestError = message
                    } else {
                        requestError = "An unknown error occurred. 4"
                    }
                case 401: requestError = "Unauthorized"
                case 403: requestError = "Access Denied"
                case 404: requestError = "Not Found"
                default:
                    print("Unknown status code: \(response.statusCode)")
                    requestError = "Unknown Error has Occured 5"
                }
                
                completion?(data, requestError)
            } else {
                completion?(data, nil)
            }
        }
        
        task.resume()
    }
    
    fileprivate class func stringFromQueryParameters(_ queryParameters: [String: String]) -> String {
        var parts = [String]()
        for (name, value) in queryParameters {
            let part = NSString(format: "%@=%@",
                                name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!,
                                value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
    fileprivate class func URLByAppendingQueryParameters(_ url: URL!, queryParameters: [String: String]) -> URL {
        let URLString = NSString(format: "%@?%@", url.absoluteString, stringFromQueryParameters(queryParameters))
        return URL(string: URLString as String)!
    }
    
}

