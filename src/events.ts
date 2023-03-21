import { NativeEventEmitter } from 'react-native';

import { TelnyxNativeSdk } from './TelnyxNativeSdk';

export const emitter = new NativeEventEmitter(TelnyxNativeSdk);
