"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;
var _TelnyxClient = require("./TelnyxClient");
var _default = new _TelnyxClient.TelnyxClient();
exports.default = _default;
//# sourceMappingURL=index.js.mapactNative.Platform.select({
  ios: "- You have run 'pod install'\n",
  default: ''
}) + '- You rebuilt the app after installing the package\n' + '- You are not using Expo Go\n';
const TelnyxSdk = _reactNative.NativeModules.TelnyxSdk ? _reactNative.NativeModules.TelnyxSdk : new Proxy({}, {
  get() {
    throw new Error(LINKING_ERROR);
  }
});
function multiply(a, b) {
  return TelnyxSdk.multiply(a, b);
}
//# sourceMappingURL=index.js.map