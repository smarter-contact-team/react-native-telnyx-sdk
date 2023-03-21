import TelnyxRTC
import React
import Foundation

@objc(TelnyxSdk)
class TelnyxSdk: RCTEventEmitter, TxClientDelegate {

  private var telnyxClient: TxClient

  override init() {
    super.init()
    telnyxClient = TxClient()

    telnyxClient.delegate = self
  }

  override static func requiresMainQueueSetup() -> Bool {
        return true
    }

    override func supportedEvents() -> [String]! {
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
            "Telnyx-onOutgoingCallInvalid"
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

      @objc(login:password:token:certificateId:)
    func login(
        withUserName userName: String,
        andPassword password: String,
        deviceToken token: String
        )
        -> Void {
            let txConfigUserAndPassowrd = TxConfig(sipUser: userName,
                                       password: password,
                                       pushDeviceToken: token)

                                       do {
          // Connect and login
          // Use `txConfigUserAndPassowrd` or `txConfigToken`
              try telnyxClient.connect(txConfig: txConfigToken)
            } catch let error {
              print("ViewController:: connect Error \(error)")
            }
    }

    @objc(logout)
    func logout() {
        telnyxClient.disconnect();

    }

    @objc(call:headers:)
    func call(withDest dest: String, andHeaders headers: [AnyHashable: Any]) -> PlivoOutgoing {
        telnyxClient?.newCall(callerName: "Caller name",
                                                     callerNumber: "155531234567",
                                                     // Destination is required and can be a phone number or SIP URI
                                                     destinationNumber: "18004377950",
                                                     callId: UUID.init())
    }

    @objc(configureAudioSession)
    func configureAudioSession() {
        endpoint.configureAudioDevice()
    }

    @objc(startAudioDevice)
    func startAudioDevice() {
        endpoint.startAudioDevice()
    }

    @objc(stopAudioDevice)
    func stopAudioDevice() {
        endpoint.stopAudioDevice()
    }

    @objc(mute)
    func mute() {
        if (outgoingCall != nil) {
            outgoingCall?.mute()
        }

        if (incomingCall != nil) {
            incomingCall?.mute()
        }
    }

    @objc(unmute)
    func unmute() {
        if (outgoingCall != nil) {
            outgoingCall?.unmute()
        }

        if (incomingCall != nil) {
            incomingCall?.unmute()
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
            incomingCall?.reject()
            incomingCall = nil
        }
    }

    func onRemoteCallEnded(callId: UUID) {
        // Call has been removed internally.
    }

    func onSocketConnected() {
       // When the client has successfully connected to the Telnyx Backend.
    }

    func onSocketDisconnected() {
       // When the client from the Telnyx backend
    }

    func onClientError(error: Error)  {
        // Something went wrong.
    }

    func onClientReady()  {
       // You can start receiving incoming calls or
       // start making calls once the client was fully initialized.
    }

    func onSessionUpdated(sessionId: String)  {
       // This function will be executed when a sessionId is received.
    }

    func onIncomingCall(call: Call)  {
       // Someone is calling you.
       // This delegate method will be called when the app is in foreground and the Telnyx Client is connected.
    }

    func onPushCall(call: Call) {
       // If you have configured Push Notifications and app is in background or the Telnyx Client is disconnected
       // this delegate method will be called after the push notification is received.
       // Update the current call with the incoming call
       self.currentCall = call
    }

        // You can update your UI from here based on the call states.
    // Check that the callId is the same as your current call.
    func onCallStateUpdated(callState: CallState, callId: UUID) {
      // handle the new call state
      switch (callState) {
      case .CONNECTING:
          break
      case .RINGING:
          break
      case .NEW:
          break
      case .ACTIVE:
          break
      case .DONE:
          break
      case .HELD:
          break
      }
    }
}
