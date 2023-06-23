import { TelnyxNativeSdk } from './TelnyxNativeSdk';
import { emitter } from './events';

enum CallState {
  DIALING = 0,
  RINGING = 1,
  ONGOING = 2,
  TERMINATED = 3,
}

interface TelnyxLoginEvent {}

interface TelnyxOutgoingEvent {
  callId: string;
  state: CallState;
  isOnHold: boolean;
  muted: boolean;
}

interface TelnyxIncomingEvent {
  callId: string;
  state: CallState;
  isOnHold: boolean;
  muted: boolean;
}

type Handler<T> = (data: T) => void;

const createListener = <T>(event: string, handler: Handler<T>) => {
  const listener = emitter.addListener(`Telnyx-${event}`, handler);
  return () => listener.remove();
};

export class TelnyxClient {
  private _isLoggedIn = false;

  login(username: string, password: string, token: string) {
    return TelnyxNativeSdk.login(username, password, token);
  }

  reconnect() {
    TelnyxNativeSdk.reconnect();
  }

  call(phoneNumber: string, headers: Record<string, string>) {
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

  setAudioDevice(device: number) {
    TelnyxNativeSdk.setAudioDevice(device);
  }

  onLogin(handler: Handler<TelnyxLoginEvent>) {
    return createListener('onLogin', (event: TelnyxLoginEvent) => {
      this._isLoggedIn = true;

      handler(event);
    });
  }

  onLoginFailed(handler: Handler<TelnyxLoginEvent>) {
    return createListener('onLoginFailed', handler);
  }

  onIncomingCall(handler: Handler<TelnyxIncomingEvent>) {
    return createListener('onIncomingCall', handler);
  }

  onIncomingCallHangup(handler: Handler<TelnyxIncomingEvent>) {
    return createListener('onIncomingCallHangup', handler);
  }

  onIncomingCallRejected(handler: Handler<TelnyxIncomingEvent>) {
    return createListener('onIncomingCallRejected', handler);
  }

  onIncomingCallInvalid(handler: Handler<TelnyxIncomingEvent>) {
    return createListener('onIncomingCallInvalid', handler);
  }

  onIncomingCallAnswered(handler: Handler<TelnyxIncomingEvent>) {
    return createListener('onIncomingCallAnswered', handler);
  }

  onOutgoingCall(handler: Handler<TelnyxOutgoingEvent>) {
    return createListener('onOutgoingCall', handler);
  }

  onOutgoingCallRinging(handler: Handler<TelnyxOutgoingEvent>) {
    return createListener('onOutgoingCallRinging', handler);
  }

  onOutgoingCallAnswered(handler: Handler<TelnyxOutgoingEvent>) {
    return createListener('onOutgoingCallAnswered', handler);
  }

  onOutgoingCallRejected(handler: Handler<TelnyxOutgoingEvent>) {
    return createListener('onOutgoingCallRejected', handler);
  }

  onOutgoingCallHangup(handler: Handler<TelnyxOutgoingEvent>) {
    return createListener('onOutgoingCallHangup', handler);
  }

  onOutgoingCallInvalid(handler: Handler<TelnyxOutgoingEvent>) {
    return createListener('onOutgoingCallInvalid', handler);
  }

  onHeadphonesStateChanged(handler: Handler<{ connected: boolean }>) {
    return createListener('headphonesStateChanged', handler);
  }
}
