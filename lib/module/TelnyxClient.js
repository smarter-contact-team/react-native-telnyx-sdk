import { TelnyxNativeSdk } from './TelnyxNativeSdk';
import { emitter } from './events';
var CallState = /*#__PURE__*/function (CallState) {
  CallState[CallState["DIALING"] = 0] = "DIALING";
  CallState[CallState["RINGING"] = 1] = "RINGING";
  CallState[CallState["ONGOING"] = 2] = "ONGOING";
  CallState[CallState["TERMINATED"] = 3] = "TERMINATED";
  return CallState;
}(CallState || {});
const createListener = (event, handler) => {
  const listener = emitter.addListener(`Telnyx-${event}`, handler);
  return () => listener.remove();
};
export class TelnyxClient {
  _isLoggedIn = false;
  login(username, password, token) {
    return TelnyxNativeSdk.login(username, password, token);
  }
  call(phoneNumber, headers) {
    return TelnyxNativeSdk.call(phoneNumber, headers);
  }
  logout() {
    TelnyxNativeSdk.logout();
    this._isLoggedIn = false;
  }
  configureAudioSession() {
    TelnyxNativeSdk.configureAudioSession();
  }
  startAudioDevice() {
    TelnyxNativeSdk.startAudioDevice();
  }
  stopAudioDevice() {
    TelnyxNativeSdk.stopAudioDevice();
  }
  mute() {
    TelnyxNativeSdk.mute();
  }
  unmute() {
    TelnyxNativeSdk.unmute();
  }
  answer() {
    TelnyxNativeSdk.answer();
  }
  hangup() {
    TelnyxNativeSdk.hangup();
  }
  reject() {
    TelnyxNativeSdk.reject();
  }
  isLoggedIn() {
    return this._isLoggedIn;
  }
  setAudioDevice(device) {
    TelnyxNativeSdk.setAudioDevice(device);
  }
  onLogin(handler) {
    return createListener('onLogin', event => {
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
//# sourceMappingURL=TelnyxClient.js.map