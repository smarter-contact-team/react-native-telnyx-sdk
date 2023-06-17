"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.TelnyxClient = void 0;
var _TelnyxNativeSdk = require("./TelnyxNativeSdk");
var _events = require("./events");
var CallState = /*#__PURE__*/function (CallState) {
  CallState[CallState["DIALING"] = 0] = "DIALING";
  CallState[CallState["RINGING"] = 1] = "RINGING";
  CallState[CallState["ONGOING"] = 2] = "ONGOING";
  CallState[CallState["TERMINATED"] = 3] = "TERMINATED";
  return CallState;
}(CallState || {});
const createListener = (event, handler) => {
  const listener = _events.emitter.addListener(`Telnyx-${event}`, handler);
  return () => listener.remove();
};
class TelnyxClient {
  _isLoggedIn = false;
  login(username, password, fcmToken, certificateId) {
    return _TelnyxNativeSdk.TelnyxNativeSdk.login(username, password, fcmToken, certificateId);
  }
  call(phoneNumber, headers) {
    return _TelnyxNativeSdk.TelnyxNativeSdk.call(phoneNumber, headers);
  }
  logout() {
    _TelnyxNativeSdk.TelnyxNativeSdk.logout();
    this._isLoggedIn = false;
  }
  configureAudioSession() {
    _TelnyxNativeSdk.TelnyxNativeSdk.configureAudioSession();
  }
  startAudioDevice() {
    _TelnyxNativeSdk.TelnyxNativeSdk.startAudioDevice();
  }
  stopAudioDevice() {
    _TelnyxNativeSdk.TelnyxNativeSdk.stopAudioDevice();
  }
  mute() {
    _TelnyxNativeSdk.TelnyxNativeSdk.mute();
  }
  unmute() {
    _TelnyxNativeSdk.TelnyxNativeSdk.unmute();
  }
  answer() {
    _TelnyxNativeSdk.TelnyxNativeSdk.answer();
  }
  hangup() {
    _TelnyxNativeSdk.TelnyxNativeSdk.hangup();
  }
  reject() {
    _TelnyxNativeSdk.TelnyxNativeSdk.reject();
  }
  isLoggedIn() {
    return this._isLoggedIn;
  }
  setAudioDevice(device) {
    _TelnyxNativeSdk.TelnyxNativeSdk.setAudioDevice(device);
  }
  onLogin(handler) {
    return createListener('onLoginFailed', event => {
      this._isLoggedIn = true;
      handler(event);
    });
  }
  onLoginFailed(handler) {
    return createListener('onLoginFailed', handler);
  }
  onIncomingCall(handler) {
    return createListener('onIncomingCall', handler);
  }
  onIncomingCallHangup(handler) {
    return createListener('onIncomingCallHangup', handler);
  }
  onIncomingCallRejected(handler) {
    return createListener('onIncomingCallRejected', handler);
  }
  onIncomingCallInvalid(handler) {
    return createListener('onIncomingCallInvalid', handler);
  }
  onIncomingCallAnswered(handler) {
    return createListener('onIncomingCallAnswered', handler);
  }
  onOutgoingCall(handler) {
    return createListener('onOutgoingCall', handler);
  }
  onOutgoingCallRinging(handler) {
    return createListener('onOutgoingCallRinging', handler);
  }
  onOutgoingCallAnswered(handler) {
    return createListener('onOutgoingCallAnswered', handler);
  }
  onOutgoingCallRejected(handler) {
    return createListener('onOutgoingCallRejected', handler);
  }
  onOutgoingCallHangup(handler) {
    return createListener('onOutgoingCallHangup', handler);
  }
  onOutgoingCallInvalid(handler) {
    return createListener('onOutgoingCallInvalid', handler);
  }
  onHeadphonesStateChanged(handler) {
    return createListener('headphonesStateChanged', handler);
  }
}
exports.TelnyxClient = TelnyxClient;
//# sourceMappingURL=TelnyxClient.js.map