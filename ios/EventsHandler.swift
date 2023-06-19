//
//  EventEmitter.swift
//  react-native-telnyx-sdk
//
//  Created by Ainur on 19.05.2023.
//

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

final class EventsHandler: TelnyxEventHandling {
    weak var eventEmitter: RCTEventEmitter?

    let supportedEvents = [
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

    init(eventEmitter: RCTEventEmitter) {
        self.eventEmitter = eventEmitter
    }

    func onLogin() {
        eventEmitter?.sendEvent(withName: "Telnyx-onLogin", body:nil);
    }

    func onLoginFailed() {
        eventEmitter?.sendEvent(withName: "Telnyx-onLoginFailed", body:nil);
    }

    func onLogout() {
        eventEmitter?.sendEvent(withName: "Telnyx-onLogout", body:nil);
    }

    func onLoginFailedWithError(_ error: Error!) {
        eventEmitter?.sendEvent(withName: "Telnyx-onLoginFailed", body:nil);
    }

    func onCalling(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onOutgoingCall", body: data);
    }

    func onOutgoingCallRejected(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onOutgoingCallRejected", body: data);
    }

    func onOutgoingCallInvalid(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onOutgoingCallInvalid", body: data);
    }

    func onOutgoingCallRinging(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onOutgoingCallRinging", body: data);
    }

    func onOutgoingCallHangup(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onOutgoingCallHangup", body: data);
    }

    func onOutgoingCallAnswered(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onOutgoingCallAnswered", body: data);
    }

    func onIncomingCall(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onIncomingCall", body: data);
    }

    func onIncomingCallHangup(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onIncomingCallHangup", body: data);
    }

    func onIncomingCallAnswered(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onIncomingCallAnswered", body: data);
    }

    func onIncomingCallInvalid(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onIncomingCallInvalid", body: data);
    }

    func onIncomingCallRejected(_ data: [String: Any]) {
        eventEmitter?.sendEvent(withName: "Telnyx-onIncomingCallRejected", body: data);
    }
}
