//
//  MyAppStoreListRemoteDataManager.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation


enum ServiceErrors:Error {
    case clientError(error : ErrorResponse?)
    case serverError(error : ErrorResponse?)
    case NoInternetConnection(error : ErrorResponse?)
    case accessError(error : ErrorResponse?)
    case validationFailed(error : ErrorResponse?)
    case unknown(response : String?)
}

enum NWServiceResult<T>{
    case success(result: T)
    case failure(error:ServiceErrors)
}

typealias GetAppInfoCompletionHandler = (_ result: NWServiceResult<MyAppInfoResponseDTO>) -> Void

class MyAppStroreListRemoteDataManager:MyAppStoreListRemoteDataManagerProtocol {


    
    public struct ErrorMessages {
        var noNetConnection = NSLocalizedString("There is no internet connection", comment: "")
        var noResponse = NSLocalizedString("Server is not responded",comment : "")
        var jsonParsing = NSLocalizedString("Failed to parse JSON",comment : "")
    }
    
    private var errorMessages = ErrorMessages()
    
    
    func  performGetAppsInfo(completion:@escaping GetAppInfoCompletionHandler){
        let apiHandler = BaseAPIHandler.sharedInstance()
        
        apiHandler.requestForApi(urlString: WebConstants.AppInfo.getAppInformation.path, method:  WebConstants.AppInfo.getAppInformation.method, parameters:nil, headers: nil, completion:{ (result) in
            switch result {
            case .success(let data):
                guard let jsonData = data else{
                    completion(.failure(error: ServiceErrors.unknown(response: self.errorMessages.noResponse)))
                    return
                }
                do{
                    let jsonDecoder = JSONDecoder()
                    let info = try jsonDecoder.decode(MyAppInfoResponseDTO.self, from: jsonData)
                    completion(.success(result:info))
                }
                catch{
                    completion(.failure(error: ServiceErrors.unknown(response: self.errorMessages.jsonParsing)))
                }
            case .failure(let error, let errorData):
                let error = self.parseError(error: error, errorData: errorData)
                completion(.failure(error: error))
            }
        })
    }
    
    
    fileprivate  func   parseError(error : APIErrors, errorData : Data?)-> ServiceErrors{
        guard let data = errorData else{
            return ServiceErrors.unknown(response: nil)
            
        }
        switch(error){
        case APIErrors.NoInternetConnection:
            let noConnection = ErrorResponse(messages:  [errorMessages.noNetConnection])
            return ServiceErrors.NoInternetConnection(error: noConnection)
            
        case APIErrors.unauthorized:fallthrough
        case APIErrors.forbiddenAccess:
            let noConnection = ErrorResponse(messages: [errorMessages.noNetConnection])
            return ServiceErrors.NoInternetConnection(error: noConnection)
        case APIErrors.internalServerError:fallthrough
        case APIErrors.pageNotfound: fallthrough
        case APIErrors.invalidData: fallthrough
        case APIErrors.badRequest: fallthrough
        case APIErrors.clientError:
            guard let responseString = String(data: data, encoding: String.Encoding.utf8) else{
                return ServiceErrors.unknown(response: nil)
            }
            
            return ServiceErrors.unknown(response: responseString)
        case APIErrors.unknown:
            guard let responseString = String(data: data, encoding: String.Encoding.utf8) else{
                return ServiceErrors.unknown(response: nil)
            }
            return ServiceErrors.unknown(response: responseString)
        }
    }
    
}
