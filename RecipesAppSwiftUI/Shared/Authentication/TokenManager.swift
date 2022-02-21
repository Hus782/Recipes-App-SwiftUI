//
//  TokenManager.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import Foundation

protocol AccessTokenManagerProtocol: AnyObject {
    func saveToken(token: String)
    func getToken() -> String?
    func hasValidSession()
    func deleteToken() throws
}

class AccessTokenManager: AccessTokenManagerProtocol, ObservableObject {
    private let keychainService: KeychainServiceProtocol
    private let account = "default"
    private let service = "accessToken"
    
    @Published var isAuthorized: Bool = false
    
    init(keychainService: KeychainServiceProtocol = KeychainService()) {
        self.keychainService = keychainService
        hasValidSession()
    }
    
    func saveToken(token: String) {
        do {
            try keychainService.storeDataFor(
                account: account,
                service: service,
                item: token)
            isAuthorized = true
        } catch let error as KeychainServiceError {
            print("Exception setting token: \(error.message)")
        } catch {
            print("An error occurred setting the password.")
        }
    }
    
    func deleteToken() throws {
        try keychainService.deleteDataFor(account: account, service: service)
        isAuthorized = false
    }
    
    func getToken() -> String? {
        do {
            let token = try keychainService.getDataFor(
                account: account,
                service: service)
            return token
        } catch let error as KeychainServiceError {
            print("Exception getting token: \(error.message)")
        } catch {
            print("An error occurred setting the password.")
        }
        return ""
    }
    
    // Decode token logic
    func hasValidSession() {
        let token =
        getToken()
        if let token = token, !token.isEmpty {
            let decodedToken = decode(jwt: token)
            guard let expDateUinx = decodedToken["exp"] else {
                isAuthorized = false
                return }
            guard let time = Double(String(describing: expDateUinx)) else {
                isAuthorized = false
                return }
            let expTokenDate = Date(timeIntervalSince1970: (time ))//+ (2*60*60)))
            let now = Date()
            if now > expTokenDate {
                isAuthorized = false
                return
            }
            isAuthorized = true
            return
        }
        isAuthorized = false
        return
    }
    
    private func decode(jwt: String) -> [String: Any] {
        
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
    private func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    private func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(
                with: bodyData, options: []), let payload = json as? [String: Any] else {
                    return nil
                }
        return payload
    }
}
