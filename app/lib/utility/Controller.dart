import 'package:sensors_plus/sensors_plus.dart';

class Controller {
  static void test() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (event.x > 2 || event.y > 2 || event.z > 2) {
        print("Stop Timer");
      }
    });
  }
}