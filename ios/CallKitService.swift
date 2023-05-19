//
//  CallKitService.swift
//  react-native-telnyx-sdk
//
//  Created by Ainur on 19.05.2023.
//

import CallKit

final class CallKitService {
    var callKitProvider: CXProvider?
    let callKitCallController = CXCallController()

    func configureAudioSession() {}

    func startAudioDevice(handle: String, phone: String, callUUID: UUID) {
        let callHandle = CXHandle(type: .generic, value: handle)
        let startCallAction = CXStartCallAction(call: callUUID, handle: CXHandle(type: .phoneNumber, value: phone))
        let transaction = CXTransaction(action: startCallAction)

        callKitCallController.request(transaction) { error in
            if let error = error {
                print("StartCallAction transaction request failed: \(error.localizedDescription)")
                return
            }

            print("StartCallAction transaction request successful")

            let callUpdate = CXCallUpdate()

            callUpdate.remoteHandle = callHandle
            callUpdate.supportsDTMF = true
            callUpdate.supportsHolding = true
            callUpdate.supportsGrouping = false
            callUpdate.supportsUngrouping = false
            callUpdate.hasVideo = false
            self.callKitProvider?.reportCall(with: callUUID, updated: callUpdate)
        }
    }


    func stopAudioDevice(callUUID: UUID) {
        let endCallAction = CXEndCallAction(call: callUUID)
        let transaction = CXTransaction(action: endCallAction)

        callKitCallController.request(transaction) { error in
            if let error = error {
                print("AppDelegate:: EndCallAction transaction request failed: \(error.localizedDescription).")
            } else {
                print("AppDelegate:: EndCallAction transaction request successful")
            }
        }
    }
}
