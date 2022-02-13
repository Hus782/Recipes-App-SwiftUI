//
//  HttpClient.swift
//  SwiftUITest1
//
//  Created by Hyusein on 15.01.22.
//

import Foundation

protocol HTTPClientProtocol {
    func getAllRecipes(completion: @escaping ((Result<[Recipe], NetworkError>) -> Void))
    func addRecipe(parameters: RecipeParameters, completion: @escaping ((Result<String, NetworkError>) -> Void))
    func editRecipe(parameters: RecipeParameters, recipeID: String, completion: @escaping ((Result<String, NetworkError>) -> Void))
    func deleteRecipe(recipeID: String, completion: @escaping ((Result<String?, NetworkError>) -> Void))
    func downloadImage(url: URL, completion: @escaping ((Result<ImageRequestResponse, NetworkError>) -> Void ))
    
}

class HTTPClient: HTTPClientProtocol {
    private let tokenManager: AccessTokenManagerProtocol
    private let httpLoader = HttpLoader()
    
    init(tokenManager: AccessTokenManagerProtocol = AccessTokenManager()) {
        self.tokenManager = tokenManager
    }
    
    func getAllRecipes(completion: @escaping ((Result<[Recipe], NetworkError>) -> Void )) {
        let request = setUpRequest(url: Constants.getAllRecipesURL, httpMethod: "GET", parameters: nil)
        
        httpLoader.load(request, RecipesResponse.self, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result.recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func addRecipe(parameters: RecipeParameters, completion: @escaping ((Result<String, NetworkError>) -> Void )) {
        let request = setUpRequest(url: Constants.getAllRecipesURL, httpMethod: "POST", parameters: parameters)
        
        httpLoader.load(request, AddRecipeResponse.self, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result.id))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func editRecipe(parameters: RecipeParameters, recipeID: String, completion: @escaping ((Result<String, NetworkError>) -> Void )) {
        let url = URL(string: Constants.editRecipeString + "/" + recipeID)!
        let request = setUpRequest(url: url, httpMethod: "PUT", parameters: parameters)
        
        httpLoader.load(request, AddRecipeResponse.self, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result.id))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func deleteRecipe(recipeID: String, completion: @escaping ((Result<String?, NetworkError>) -> Void )) {
        let url = URL(string: Constants.editRecipeString + "/" + recipeID)!
        let request = setUpRequest(url: url, httpMethod: "DELETE", parameters: nil)
        
        httpLoader.load(request, completion: { result in
            switch result {
            case .success(_):
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func downloadImage(url: URL, completion: @escaping ((Result<ImageRequestResponse, NetworkError>) -> Void )) {
        httpLoader.loadImage(url: url, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    private func setUpRequest(url: URL, httpMethod: String, parameters: RecipeParameters?) -> URLRequest{
        var request = URLRequest(url: url)
        let encoder = JSONEncoder()
        do {
            if let parameters = parameters {
                let httpBody = try encoder.encode(parameters)
                request.httpBody = httpBody
            }
            request.httpMethod = httpMethod
            let token = tokenManager.getToken() ?? ""
            request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        } catch let error {
            print(error)
        }
        return request
    }
}
