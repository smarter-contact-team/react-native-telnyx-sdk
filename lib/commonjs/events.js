"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.emitter = void 0;
var _reactNative = require("react-native");
var _TelnyxNativeSdk = require("./TelnyxNativeSdk");
const emitter = new _reactNative.NativeEventEmitter(_TelnyxNativeSdk.TelnyxNativeSdk);
exports.emitter = emitter;
//# sourceMappingURL=events.js.map