import TelnyxRTC
import React


final class TelnyxSdk: NSObject {
    static let shared = TelnyxSdk()

    weak var delegate: TelnyxEventHandling?

    private let telnyxClient: TxClient = TxClient()
    private let credentialsManager = CredentialsManager()

    private var outgoingCall: Call?
    private var incomingCall: Call?

    override init() {
        super.init()

        telnyxClient.delegate = self
    }

    func login(username: String, password: String, deviceToken: String) -> Void {
        let txConfig = TxConfig(sipUser: username, password: password, pushDeviceToken: deviceToken)

        do {
            try telnyxClient.connect(txConfig: txConfig)
            credentialsManager.saveCredentials(username, password, deviceToken)
        } catch let error {
            print("(telnyx): connect error: \(error)")
        }
    }

    func logout() {
        telnyxClient.disconnect()
        credentialsManager.deleteCredentials()
    }

    func processVoIPNotification() {
        guard let username = credentialsManager.username,
              let password = credentialsManager.password,
              let deviceToken = credentialsManager.deviceToken else {
            return

        }

        let txConfig = TxConfig(sipUser: username,
                                password: password,
                                pushDeviceToken: deviceToken)

        do {
            try telnyxClient.processVoIPNotification(txConfig: txConfig, serverConfiguration: TxServerConfiguration(environment: .production))
        } catch let error {
            print("(telnyx): processVoIPNotification Error \(error)")
        }
    }

    func call(dest: String, headers: [AnyHashable: Any]) {
        let callerNumber = String(describing: headers["X-PH-callerId"]!).replacingOccurrences(of: "+", with: "")
        let destinationNumber = dest.replacingOccurrences(of: "+", with: "")

        let uuid = UUID.init()
        do {
            outgoingCall = try telnyxClient.newCall(callerName: "",
                                                    callerNumber: callerNumber,
                                                    destinationNumber: destinationNumber,
                                                    callId: uuid)
            telnyxClient.isAudioDeviceEnabled = true
        } catch let err {
            print(err)
        }
    }

    @objc(mute)
    func mute() {
        if (outgoingCall != nil) {
            outgoingCall?.muteAudio()
        }

        if (incomingCall != nil) {
            incomingCall?.muteAudio()
        }
    }

    @objc(unmute)
    func unmute() {
        if (outgoingCall != nil) {
            outgoingCall?.unmuteAudio()
        }

        if (incomingCall != nil) {
            incomingCall?.unmuteAudio()
        }
    }

    @objc(answer)
    func answer() {
        if (incomingCall != nil) {
            incomingCall?.answer()
        }
    }

    @objc(hangup)
    func hangup() {
        if (outgoingCall != nil) {
            outgoingCall?.hangup()
            outgoingCall = nil
        }

        if (incomingCall != nil) {
            incomingCall?.hangup()
            outgoingCall = nil
        }
    }

    @objc(reject)
    func reject() {
        if (incomingCall != nil) {
            incomingCall?.hangup()
            incomingCall = nil
        }
    }
}

extension TelnyxSdk: TxClientDelegate {
    /// When the client has successfully connected to the Telnyx Backend.
    func onSocketConnected() {
        print("(telnyx): onSocketConnected")
    }

    /// This function will be executed when a sessionId is received.
    func onSessionUpdated(sessionId: String)  {
        print("(telnyx): onSessionUpdated")
    }

    /// When the client disconnected from the Telnyx backend.
    func onSocketDisconnected() {
        print("(telnyx): onSocketDisconnected")
    }

    /// You can start receiving incoming calls or start making calls once the client was fully initialized.
    func onClientReady()  {
        delegate?.onLogin()
        print("(telnyx): onClientReady")
    }

    /// Something went wrong.
    func onClientError(error: Error)  {
        delegate?.onLoginFailedWithError(error)
        print("(telnyx): onClientError", error.localizedDescription, error)
    }

    /// This delegate method will be called when the app is in foreground and the Telnyx Client is connected.
    func onIncomingCall(call: Call)  {
        incomingCall = call
        print("(telnyx): INCOMING CALL")
        delegate?.onIncomingCall(convertCallInfoToDict(call))
    }

    /// If you have configured Push Notifications and app is in background or the Telnyx Client is disconnected this delegate method will be called after the push notification is received.
    func onPushCall(call: Call) {
       incomingCall = call
        print("(telnyx): PUSH CALL")
        delegate?.onIncomingCall(convertCallInfoToDict(call))
    }

    /// Call has been removed internally.
    func onRemoteCallEnded(callId: UUID) {
        if outgoingCall != nil {
            delegate?.onOutgoingCallHangup(["callId": callId.uuidString])
        }

        if incomingCall != nil {
            delegate?.onIncomingCallHangup(["callId": callId.uuidString])
        }
        print("(telnyx): onRemoteCallEnded")
    }

    /// You can update your UI from here based on the call states.
    /// Check that the callId is the same as your current call.
    func onCallStateUpdated(callState: CallState, callId: UUID) {
      switch (callState) {
      case .CONNECTING:
          print("(telnyx): connecting")
          delegate?.onCalling(["callId": callId.uuidString])
          break

      case .RINGING:
          print("(telnyx): ringing")
          delegate?.onOutgoingCallRinging(["callId": callId.uuidString])
          break

      case .NEW:
          print("(telnyx): new")
          break

      case .ACTIVE:
          print("(telnyx): active")
          telnyxClient.isAudioDeviceEnabled = true
          if outgoingCall != nil {
              delegate?.onOutgoingCallAnswered(["callId": callId.uuidString])
          }
          if incomingCall != nil {
              delegate?.onIncomingCallAnswered(["callId": callId.uuidString])
          }
          break

      case .DONE:
          print("(telnyx): done")
          telnyxClient.isAudioDeviceEnabled = false
          if outgoingCall != nil {
              delegate?.onOutgoingCallHangup(["callId": callId.uuidString])
          }
          if incomingCall != nil {
              delegate?.onIncomingCallHangup(["callId": callId.uuidString])
          }
          break

      case .HELD:
          print("(telnyx): held")
          break
      }
    }

    private func convertCallInfoToDict(_ call: Call) -> [String: String?] {
        let data: [String] = call.callInfo?.callerName?.components(separatedBy: "~~") ?? [];
        let body: [String: String?] = [
            "callId": call.callInfo?.callId.uuidString ?? "",
            "callerName": data[0],
            "callerPhone": call.callInfo?.callerNumber ?? "",
            "callerId" : data[1]
        ]

        return body
    }
}
