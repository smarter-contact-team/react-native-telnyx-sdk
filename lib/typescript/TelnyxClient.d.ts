declare enum CallState {
    DIALING = 0,
    RINGING = 1,
    ONGOING = 2,
    TERMINATED = 3
}
interface PlivoLoginEvent {
}
interface PlivoOutgoingEvent {
    callId: string;
    state: CallState;
    isOnHold: boolean;
    muted: boolean;
}
interface PlivoIncomingEvent {
    callId: string;
    state: CallState;
    isOnHold: boolean;
    muted: boolean;
}
type Handler<T> = (data: T) => void;
export declare class TelnyxClient {
    private _isLoggedIn;
    login(username: string, password: string, token: string): any;
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
    onLogin(handler: Handler<PlivoLoginEvent>): () => void;
    onLoginFailed(handler: Handler<PlivoLoginEvent>): () => void;
    onIncomingCall(handler: Handler<PlivoIncomingEvent>): () => void;
    onIncomingCallHangup(handler: Handler<PlivoIncomingEvent>): () => void;
    onIncomingCallRejected(handler: Handler<PlivoIncomingEvent>): () => void;
    onIncomingCallInvalid(handler: Handler<PlivoIncomingEvent>): () => void;
    onIncomingCallAnswered(handler: Handler<PlivoIncomingEvent>): () => void;
    onOutgoingCall(handler: Handler<PlivoOutgoingEvent>): () => void;
    onOutgoingCallRinging(handler: Handler<PlivoOutgoingEvent>): () => void;
    onOutgoingCallAnswered(handler: Handler<PlivoOutgoingEvent>): () => void;
    onOutgoingCallRejected(handler: Handler<PlivoOutgoingEvent>): () => void;
    onOutgoingCallHangup(handler: Handler<PlivoOutgoingEvent>): () => void;
    onOutgoingCallInvalid(handler: Handler<PlivoOutgoingEvent>): () => void;
    onHeadphonesStateChanged(handler: Handler<{
        connected: boolean;
    }>): () => void;
}
export {};
//# sourceMappingURL=TelnyxClient.d.ts.map