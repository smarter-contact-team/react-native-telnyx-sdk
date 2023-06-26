//
//  TelnyxSdkManager.swift
//  react-native-telnyx-sdk
//
//  Created by Ainur on 17.05.2023.
//

import Foundation
import TelnyxRTC
import React

protocol TelnyxEventHandling: AnyObject {
    // Login
    func onLogin()
    func onLoginFailed()
    func onLogout()
    func onLoginFailedWithError(_ error: Error!)
    // Outgoing call
    func onCalling(_ data: [String: Any])
    func onOutgoingCallRejected(_ data: [String: Any])
    func onOutgoingCallInvalid(_ data: [String: Any])
    func onOutgoingCallRinging(_ data: [String: Any])
    func onOutgoingCallHangup(_ data: [String: Any])
    func onOutgoingCallAnswered(_ data: [String: Any])
    // Incoming call
    func onIncomingCall(_ data: [String: Any])
    func onIncomingCallHangup(_ data: [String: Any])
    func onIncomingCallAnswered(_ data: [String: Any])
    func onIncomingCallInvalid(_ data: [String: Any])
    func onIncomingCallRejected(_ data: [String: Any])
}

@objc(TelnyxSdkManager)
final class TelnyxSdkManager: RCTEventEmitter, TelnyxEventHandling {
    private let shared = TelnyxSdk.shared
    private let audioDeviceManager = AudioDeviceManager()

    private var hasListeners : Bool = false

    override init() {
        super.init()

        TelnyxSdk.shared.delegate = self
        audioDeviceManager.delegate = self
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }

    override func supportedEvents() -> [String] {
        return [
            "Telnyx-onLogin",
            "Telnyx-onLoginFailed",
            "Telnyx-onLogout",
            "Telnyx-onIncomingCall",
            "Telnyx-onIncomingCallHangup",
            "Telnyx-onIncomingCallRejected",
            "Telnyx-onIncomingCallAnswered",
            "Telnyx-onIncomingCallInvalid",
            "Telnyx-onOutgoingCall",
            "Telnyx-onOutgoingCallAnswered",
            "Telnyx-onOutgoingCallRinging",
            "Telnyx-onOutgoingCallRejected",
            "Telnyx-onOutgoingCallHangup",
            "Telnyx-onOutgoingCallInvalid",
            "Telnyx-headphonesStateChanged"
        ]
    }

    override func startObserving() {
        print("TelnyxSdk ReactNativeEventEmitter startObserving")

        hasListeners = true

        super.startObserving()
    }


    override func stopObserving() {
        print("TelnyxSdk ReactNativeEventEmitter stopObserving")

        hasListeners = false

        super.stopObserving()
    }

    @objc(login:password:token:)
    func login(
        withUserName userName: String,
        andPassword password: String,
        deviceToken token: String
        )
        -> Void {
            TelnyxSdk.shared.login(username: userName,
                                   password: password,
                                   deviceToken: token)
    }

    @objc func reconnect() {
        shared.reconnect()
    }

    @objc func logout() {
        shared.logout()
    }

    @objc static func processVoIPNotification() {
        TelnyxSdk.shared.processVoIPNotification()
    }

    @objc(call:headers:)
    func call(withDest dest: String, andHeaders headers: [AnyHashable: Any]) {
        return shared.call(dest: dest, headers: headers)
    }

    @objc func mute() {
        shared.mute()
    }

    @objc func unmute() {
        shared.unmute()
    }

    @objc func answer() {
        shared.answer()
    }

    @objc func hangup() {
        shared.hangup()
    }

    @objc func reject() {
        shared.reject()
    }

    @objc func setAudioDevice(_ device: Int) {
        audioDeviceManager.setAudioDevice(type: device)
    }

    func onLogin() {
        sendEvent(withName: "Telnyx-onLogin", body:nil);
    }

    func onLoginFailed() {
        sendEvent(withName: "Telnyx-onLoginFailed", body:nil);
    }

    func onLogout() {
        sendEvent(withName: "Telnyx-onLogout", body:nil);
    }

    func onLoginFailedWithError(_ error: Error!) {
        let body = ["error": error.localizedDescription]
        sendEvent(withName: "Telnyx-onLoginFailed", body: body);
    }

    func onCalling(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onOutgoingCall", body: data);
    }

    func onOutgoingCallRejected(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onOutgoingCallRejected", body: data);
    }

    func onOutgoingCallInvalid(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onOutgoingCallInvalid", body: data);
    }

    func onOutgoingCallRinging(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onOutgoingCallRinging", body: data);
    }

    func onOutgoingCallHangup(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onOutgoingCallHangup", body: data);
    }

    func onOutgoingCallAnswered(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onOutgoingCallAnswered", body: data);
    }

    func onIncomingCall(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onIncomingCall", body: data);
    }

    func onIncomingCallHangup(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onIncomingCallHangup", body: data);
    }

    func onIncomingCallAnswered(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onIncomingCallAnswered", body: data);
    }

    func onIncomingCallInvalid(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onIncomingCallInvalid", body: data);
    }

    func onIncomingCallRejected(_ data: [String: Any]) {
        sendEvent(withName: "Telnyx-onIncomingCallRejected", body: data);
    }
}

extension TelnyxSdkManager: AudioDeviceManagerDelegate {
    func didChangeHeadphonesState(connected: Bool) {
        sendEvent(withName: "Telnyx-headphonesStateChanged", body: ["connected": connected])
    }
}
