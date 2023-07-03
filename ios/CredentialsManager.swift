//
//  TelnyxClient.swift
//  react-native-telnyx-sdk
//
//  Created by Ainur on 19.05.2023.
//

import Foundation

struct CredentialsManager {
    enum Constants {
        static let usernameKey = "com.telnyx.username"
        static let passwordKey = "com.telnyx.password"
        static let deviceTokenKey = "com.telnyx.deviceToken"
    }

    var username: String? {
        retrieveItemFromKeychain(service: Constants.usernameKey)
    }

    var password: String? {
        retrieveItemFromKeychain(service: Constants.passwordKey)
    }

    var deviceToken: String? {
        retrieveItemFromKeychain(service: Constants.deviceTokenKey)
    }

    func saveCredentials(_ username: String,
                         _ password: String,
                         _ deviceToken: String) {
        addOrUpdateItemInKeychain(service: Constants.usernameKey, value: username)
        addOrUpdateItemInKeychain(service: Constants.passwordKey, value: password)
        addOrUpdateItemInKeychain(service: Constants.deviceTokenKey, value: deviceToken)
    }

    func deleteCredentials() {
        deleteItemFromKeychain(service: Constants.usernameKey)
        deleteItemFromKeychain(service: Constants.passwordKey)
        deleteItemFromKeychain(service: Constants.deviceTokenKey)
    }

    @discardableResult
    private func addOrUpdateItemInKeychain(service: String, value: String) -> Bool {
        let account = "telnyx"
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
            kSecValueData as String: value.data(using: .utf8)!
        ]

        var status = SecItemAdd(keychainQuery as CFDictionary, nil)
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            ]
            let updateData: [String: Any] = [
                kSecValueData as String: value.data(using: .utf8)!
            ]
            status = SecItemUpdate(updateQuery as CFDictionary, updateData as CFDictionary)
            return status == errSecSuccess
        } else {
            return false
        }
    }

    @discardableResult
    private func deleteItemFromKeychain(service: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }

    private func retrieveItemFromKeychain(service: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: "telnyx",
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                return String(data: retrievedData, encoding: .utf8)
            }
        }

        return nil
    }
}
