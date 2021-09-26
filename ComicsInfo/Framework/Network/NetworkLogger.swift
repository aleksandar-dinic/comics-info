//
//  NetworkLogger.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2021.
//

import Foundation

enum NetworkLogger {
    
    static func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        
        let method = "\(request.httpMethod ?? "")"
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) \n
                        HOST: \(host)\n
                        """
        
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        
        if let body = request.httpBody {
            logOutput += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        
        print(logOutput)
        
        print("\n - - - - - - - - - -  END - - - - - - - - - - \n")
    }
    
    static func log(data: Data?, response: URLResponse?, error: Error?) {
        print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        
        var logOutput = ""

        if let url = response?.url {
            logOutput += "URL: \(url.absoluteString) \n"
        }
        
        if let error = error {
            logOutput += "ERROR: \(error.localizedDescription) \n\n"
        } else {
            logOutput += "No error \n\n"
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) ?? .undefined
            logOutput += "HTTPResponse status: \(statusCode.rawValue) \(statusCode) \n\n"
        } else {
            logOutput += "Response is not HTTPResponse \n\n"
        }
        
        if let data = data {
            logOutput += "Data: \n \(String(data: data, encoding: .utf8) ?? "")"
        } else {
            logOutput += "Data is missing"
        }

        print(logOutput)
        
        print("\n - - - - - - - - - -  END - - - - - - - - - - \n")
    }
    
}
