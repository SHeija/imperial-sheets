// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App sanity test', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final confirmButtonFinder = find.byValueKey('Confirm');
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Tutorial appears, and can be dismissed', () async {
      expect(await driver.getText(find.byValueKey('Tutorial')), "Tutorial");
      await driver.tap(confirmButtonFinder);
      await driver.waitForAbsent(find.text('Tutorial'));
    });
  });
}
