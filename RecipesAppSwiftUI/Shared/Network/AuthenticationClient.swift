//
//  AuthenticationClient.swift
//  SwiftUITest1
//
//  Created by Hyusein on 8.02.22.
//

import Foundation

class AuthenticationClient {
    private let httpLoader = HttpLoader()
    
    func login(parameters: AuthenticationParameters, completion: @escaping ((Result<String, NetworkError>) -> Void )) {

        let request = setUpAuthenticationRequest(url: Constants.singinURL, httpMethod: "POST", parameters: parameters)
        
        httpLoader.load(request, AuthenticationResponse.self, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result.authToken))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
//    func register(parameters: AuthenticationParameters, completion: @escaping ((Result<String?, NetworkError>) -> Void )) {
//        let request = setUpAuthenticationRequest(url: Constants.singupURL, httpMethod: "POST", parameters: parameters)
//
//        requestService.sendRegisterRequest(request: request, completion: {
//            result in
//            switch result {
//            case .success(let id):
//                completion(.success(id))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//    }
    
    private func setUpAuthenticationRequest(url: URL, httpMethod: String, parameters: AuthenticationParameters) -> URLRequest{
        var request = URLRequest(url: url)
        let encoder = JSONEncoder()
        do {
            let httpBody = try encoder.encode(parameters)
            request.httpMethod = httpMethod
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
        } catch let error {
            print(error)
        }
        return request
    }
    
}
