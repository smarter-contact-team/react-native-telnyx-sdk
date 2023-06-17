//
//  TelnyxSdkManager.swift
//  react-native-telnyx-sdk
//
//  Created by Ainur on 17.05.2023.
//

import Foundation
import TelnyxRTC
import React


@objc(TelnyxSdkManager)
final class TelnyxSdkManager: RCTEventEmitter {
    private let shared = TelnyxSdk.shared
    private let audioDeviceManager = AudioDeviceManager()

    private lazy var eventsHandler: EventsHandler = {
        let eventsHandler = EventsHandler(eventEmitter: self)
        TelnyxSdk.shared.delegate = eventsHandler

        return eventsHandler
    }()

    override init() {
        super.init()

        audioDeviceManager.delegate = self
    }

    override func supportedEvents() -> [String] {
        return eventsHandler.supportedEvents
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

    @objc func logout() {
        shared.logout()
    }

    @objc static func processVoIPNotification(callUUID: UUID) {
        TelnyxSdk.shared.processVoIPNotification(callUUID: callUUID)
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
}

extension TelnyxSdkManager: AudioDeviceManagerDelegate {
    func didChangeHeadphonesState(connected: Bool) {
        sendEvent(withName: "Telnyx-headphonesStateChanged", body: ["connected": connected])
    }
}
