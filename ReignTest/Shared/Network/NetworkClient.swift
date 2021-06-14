//
//  NetworkClient.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 11/06/21.
//

import Foundation

enum ResponseNetwork<T> {
    case failure(error: Error)
    case success(data: T)
}

enum HttpMethod: String {
    case Gest = "GET"
    case Post = "POST"
}

protocol NetworkClient {
    func callService<T:Decodable>(from url: String,
                                  method: HttpMethod,
                                  headers: [String: String]?,
                                  body: [String: Any]?,
                                  objectType: T.Type,
                                  completion: @escaping((ResponseNetwork<T>) -> Void))
}

extension NetworkClient {
    func callService<T:Decodable>(from url: String,
                                  method: HttpMethod,
                                  headers: [String: String]? = nil,
                                  body: [String: Any]? = nil,
                                  objectType: T.Type,
                                  completion: @escaping((ResponseNetwork<T>) -> Void)) {
        
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        sessionConfig.timeoutIntervalForResource = 60
        
        let session = URLSession(configuration: sessionConfig)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
            }
            
            if let data = data {
                do {
                    _ = try? JSONSerialization.jsonObject(with: data, options: [])
                    let decoder = JSONDecoder()
                    let decodedObject = try decoder.decode(objectType.self, from: data)
                    completion(.success(data: decodedObject))
                }catch(let exception) {
                    print("exception: \(exception.localizedDescription)")
                    completion(.failure(error: exception))
                }
            }
        }.resume()
    }
}
