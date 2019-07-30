import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/screenshots.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('fake', () async {
    final configInfo = Config().configInfo;
    print('configInfo: $configInfo');
//    await Future.delayed(Duration(seconds: 2));
//    print('hi');
    await screenshot(driver, configInfo, 'myscreenshot1');

    expect(configInfo.isEmpty, isFalse);
  });
}
