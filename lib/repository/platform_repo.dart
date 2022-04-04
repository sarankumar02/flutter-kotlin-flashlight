import 'package:flutter/services.dart';

class PlatformRepository {
  static const platform =
      MethodChannel('flutter.native/helper'); // name of our method channel

  Future<bool> turnOnOrOffFlashLight() async {
    bool result = false;
    try {
      result = await platform.invokeMethod("flashLightOnOrOff");
      return result;
    } on PlatformException catch (e) {
      // print(e.message! + " Message");
      return result;
    }
  }
}
