//
//  BaseAPIHandler.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import Foundation
import Alamofire

public enum BaseAPIResult<T>{
    case success(result: T)
    case failure(error:APIErrors,data: Data?)
}

public enum APIErrors : Error{
    case badRequest
    case forbiddenAccess
    case pageNotfound
    case invalidData
    case unauthorized
    case unknown
    case internalServerError
    case NoInternetConnection
    case clientError
}

public enum Environment {
    case DEVELOPMENT
    case STAGING
    case PRODUCTION
}

public typealias ApiRequestCompletionHandler = (_ result: BaseAPIResult<Data?>) -> Void

public class BaseAPIHandler : NSObject {
    static var shared : BaseAPIHandler?  = nil;
    var baseUrl : String?
    private override init() {}
    
    public class func sharedInstance()->BaseAPIHandler {
        if(shared == nil){
            shared = BaseAPIHandler()
            shared?.baseUrl = "https://itunes.apple.com/"
        }
        return shared!
    }
    
    public func requestForApi (urlString:String, otherBaseUrl: String? = nil, method:HTTPMethod,
                               parameters: [String: Any]?,headers :HTTPHeaders?,urlEncoding : URLEncoding = URLEncoding.default, jsonEncoding: ParameterEncoding? = nil, completion:@escaping ApiRequestCompletionHandler)
    {
        
        let baseUrlString = otherBaseUrl == nil ? baseUrl : otherBaseUrl
        let url = "\(baseUrlString!)\(urlString)"
        var encoding: ParameterEncoding = (method == .put || method == .post) ? JSONEncoding.default : urlEncoding
        if jsonEncoding != nil {
            encoding = jsonEncoding!
        }
        
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding,headers:headers)
        self.fireRequest(request: request, completion: completion)
    }
    
    
    public func   requestForDeleteApi (urlString:String,method:HTTPMethod,
                                       parameters: [String: String]?,headers :HTTPHeaders, completion:@escaping ApiRequestCompletionHandler)
    {
        
        let url = "\(baseUrl!)\(urlString)"
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.httpBody,headers:headers)
        self.fireRequest(request: request, completion: completion)
    }
    
    
    private func   fireRequest(request : DataRequest, completion : @escaping ApiRequestCompletionHandler){
        request.responseString { (response) in
            let statusCode = response.response?.statusCode ?? 400
            
            switch(statusCode){
            case 0:
                completion(.failure(error: APIErrors.NoInternetConnection,data: response.data))
            case 200:
                completion(.success(result: response.data));
            case 201:
                completion(.success(result: response.data));
            case 401:
                completion(.failure(error: APIErrors.unauthorized,data: response.data))
            case 422:
                completion(.failure(error: APIErrors.clientError,data: response.data))
            case 400:
                completion(.failure(error: APIErrors.invalidData,data: response.data))
            case 404:
                completion(.failure(error: APIErrors.pageNotfound,data: response.data))
            case 403:
                completion(.failure(error: APIErrors.forbiddenAccess,data: response.data))
                
                fallthrough
            default:
                completion(.failure(error: APIErrors.unknown,data: response.data))
            }
        }
    }
}

