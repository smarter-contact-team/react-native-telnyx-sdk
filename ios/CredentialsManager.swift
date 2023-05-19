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
        readItemFromKeychain(service: Constants.usernameKey)
    }

    var password: String? {
        readItemFromKeychain(service: Constants.passwordKey)
    }

    var deviceToken: String? {
        readItemFromKeychain(service: Constants.deviceTokenKey)
    }

    func saveCredentials(_ username: String,
                         _ password: String,
                         _ deviceToken: String) {
        addItemToKeychain(service: Constants.usernameKey, value: username)
        addItemToKeychain(service: Constants.passwordKey, value: password)
        addItemToKeychain(service: Constants.deviceTokenKey, value: deviceToken)
    }

    func deleteCredentials() {
        deleteItemFromKeychain(service: Constants.usernameKey)
        deleteItemFromKeychain(service: Constants.passwordKey)
        deleteItemFromKeychain(service: Constants.deviceTokenKey)
    }

    @discardableResult
    private func addItemToKeychain(service: String, value: String) -> Bool {
        let account = "telnyx"
        var keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let dataToSave = value.data(using: .utf8)!
        keychainQuery[kSecValueData as String] = dataToSave

        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        return status == errSecSuccess
    }

    @discardableResult
    func deleteItemFromKeychain(service: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }

    @discardableResult
    func readItemFromKeychain(service: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: service,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else { return nil }
        let itemData = item as! Data
        return String(data: itemData, encoding: .utf8)
    }
}
