//
//  Keychain.swift
//  SwiftUITest1
//
//  Created by Hyusein on 22.01.22.
//

import Foundation

protocol KeychainProtocol: AnyObject {
    func save(_ query: [String: Any]) -> OSStatus
    func fetch(_ query: [String: Any]) -> (status: OSStatus, item: CFTypeRef?)
    func update(_ query: [String: Any], _ attributes: [String: Any]) -> OSStatus
    func delete(_ query: [String: Any]) -> OSStatus
}

class Keychain: KeychainProtocol {
    func save(_ query: [String: Any]) -> OSStatus {
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    func fetch(_ query: [String: Any]) -> (status: OSStatus, item: CFTypeRef?) {
        var item: AnyObject?
        let status = withUnsafeMutablePointer(to: &item) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        return (status, item)
    }
    
    func update(_ query: [String: Any], _ attributes: [String: Any]) -> OSStatus {
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
    }
    
    func delete(_ query: [String: Any]) -> OSStatus {
        return SecItemDelete(query as CFDictionary)
    }
}
