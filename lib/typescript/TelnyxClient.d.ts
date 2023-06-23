declare enum CallState {
    DIALING = 0,
    RINGING = 1,
    ONGOING = 2,
    TERMINATED = 3
}
interface TelnyxLoginEvent {
}
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
export declare class TelnyxClient {
    private _isLoggedIn;
    login(username: string, password: string, token: string): any;
    reconnect(): void;
    call(phoneNumber: string, headers: Record<string, string>): any;
    logout(): void;
    configureAudioSession(): void;
    startAudioDevice(): void;
    stopAudioDevice(): void;
    mute(): void;
    unmute(): void;
    answer(): void;
    hangup(): void;
    reject(): void;
    isLoggedIn(): boolean;
    setAudioDevice(device: number): void;
    onLogin(handler: Handler<TelnyxLoginEvent>): () => void;
    onLoginFailed(handler: Handler<TelnyxLoginEvent>): () => void;
    onIncomingCall(handler: Handler<TelnyxIncomingEvent>): () => void;
    onIncomingCallHangup(handler: Handler<TelnyxIncomingEvent>): () => void;
    onIncomingCallRejected(handler: Handler<TelnyxIncomingEvent>): () => void;
    onIncomingCallInvalid(handler: Handler<TelnyxIncomingEvent>): () => void;
    onIncomingCallAnswered(handler: Handler<TelnyxIncomingEvent>): () => void;
    onOutgoingCall(handler: Handler<TelnyxOutgoingEvent>): () => void;
    onOutgoingCallRinging(handler: Handler<TelnyxOutgoingEvent>): () => void;
    onOutgoingCallAnswered(handler: Handler<TelnyxOutgoingEvent>): () => void;
    onOutgoingCallRejected(handler: Handler<TelnyxOutgoingEvent>): () => void;
    onOutgoingCallHangup(handler: Handler<TelnyxOutgoingEvent>): () => void;
    onOutgoingCallInvalid(handler: Handler<TelnyxOutgoingEvent>): () => void;
    onHeadphonesStateChanged(handler: Handler<{
        connected: boolean;
    }>): () => void;
}
export {};
//# sourceMappingURL=TelnyxClient.d.ts.map