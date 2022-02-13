//
//  HttpRequestManager.swift
//  SwiftUITest1
//
//  Created by Hyusein on 8.02.22.
//

import Foundation
import UIKit

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class HttpLoader {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func load<T: Codable>(_ request: URLRequest,
                          _ model: T.Type,
                          completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, _ in
            if !self.isResponseSuccess(response: response) {
                DispatchQueue.main.async {
                    completion(.failure(.responseError))
                }
                return
            }
            
            let responseData = self.decodeResponseData(data: data, type: model)
            if let responseData = responseData {
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func load(_ request: URLRequest,
                          completion: @escaping (Result<String?, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, _ in
            if !self.isResponseSuccess(response: response) {
                DispatchQueue.main.async {
                    completion(.failure(.responseError))
                }
                return
            }

                DispatchQueue.main.async {
                    completion(.success(nil))
                }
 
        }.resume()
    }
    
    func loadImage(url: URL, completion: @escaping ((Result<ImageRequestResponse, NetworkError>) -> Void )) {
        session.dataTask(with: url) { (data, response, error) in
            if !self.isResponseSuccess(response: response) {
                completion(.failure(.responseError))
                return
            }
            guard let responseData = data, let image = UIImage(data: responseData) else {
                completion(.failure(.decodingError))
                return
            }
            let results = ImageRequestResponse(image: image, url: url, cost: responseData.count)
            
            completion(.success(results))
        }.resume()
    }
    
    
    private func decodeResponseData<T>(data: Data?, type: T.Type) -> T? where T: Decodable{
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(type, from: data)
                return json
            } catch {
                return nil
            }
        }
        return nil
    }
    
    private func isResponseSuccess(response: URLResponse?) -> Bool{
        if let response = response as? HTTPURLResponse , (200..<300).contains(response.statusCode) {
            //print(response)
            return true
        }
        else {
            return false
        }
    }
    
    private func isAuthorized(response: URLResponse?) -> Bool{
        if let response = response as? HTTPURLResponse , response.statusCode == 401 {
            return false
        }
        else {
            return true
        }
    }
    
}
