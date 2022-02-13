//
//  KeychainService.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import Foundation
import Security

struct KeychainServiceError: Error {
    let message: String
    let type: KeychainErrorType
    
    enum KeychainErrorType {
        case badData
        case servicesError
        case itemNotFound
        case unableToConvertToString
    }
    
    init(status: OSStatus, type: KeychainErrorType) {
        self.type = type
        if let errorMessage = SecCopyErrorMessageString(status, nil) {
            self.message = String(errorMessage)
        } else {
            self.message = "Status Code: \(status)"
        }
    }
    
    init(type: KeychainErrorType) {
        self.type = type
        self.message = ""
    }
    
    init(message: String, type: KeychainErrorType) {
        self.message = message
        self.type = type
    }
}


protocol KeychainServiceProtocol: AnyObject {
    func storeDataFor(account: String, service: String, item: String) throws
    func getDataFor(account: String, service: String) throws -> String
    func updateDataFor(account: String, service: String, item: String) throws
    func deleteDataFor(account: String, service: String) throws
}

class KeychainService: KeychainServiceProtocol {
    private let keychain: KeychainProtocol
    
    init(keychain: KeychainProtocol = Keychain()) {
        self.keychain = keychain
    }
    
    func storeDataFor(account: String, service: String, item: String) throws {
        guard let itemData = item.data(using: .utf8) else {
            print("Error while converting to data")
            throw KeychainServiceError(type: .badData)
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: itemData
        ]
        
        let status = keychain.save(query)
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try updateDataFor(
                account: account,
                service: service,
                item: item)
        default:
            throw KeychainServiceError(status: status, type: .servicesError)
        }
    }
    
    func getDataFor(account: String, service: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        let (status, item) = keychain.fetch(query)
        guard status != errSecItemNotFound else {
            throw KeychainServiceError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainServiceError(status: status, type: .servicesError)
        }
        
        guard
            let existingItem = item as? [String: Any],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: .utf8)
        else {
            throw KeychainServiceError(type: .unableToConvertToString)
        }
        
        return value
    }
    
    func updateDataFor(account: String, service: String, item: String) throws {
        guard let itemData = item.data(using: .utf8) else {
            print("Error converting value to data.")
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: itemData
        ]
        
        let status = keychain.update(query, attributes)
        guard status != errSecItemNotFound else {
            throw KeychainServiceError(message: "Matching Item Not Found", type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainServiceError(status: status, type: .servicesError)
        }
    }
    
    func deleteDataFor(account: String, service: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let status = keychain.delete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainServiceError(status: status, type: .servicesError)
        }
    }
}
