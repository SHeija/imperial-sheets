// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'loremIpsum.dart' as loremIpsum;

void main() {
  group('Sanity check', () {
    final confirmButton = find.text('Confirm');
    final drawerButton = find.byTooltip('Open navigation menu');
    final deleteCharacter = find.byTooltip('Delete character');
    final createCharacter = find.text('Add new character');
    final ch1name = 'First one';
    final ch2name = 'Second one';
    final ch1desc = 'Description of the first character';
    final ch2desc = 'Description of the second character';
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Tutorial appears, and can be dismissed', () async {
      await driver.waitFor(find.text('Tutorial'));
      await driver.tap(confirmButton);
      await driver.waitForAbsent(find.text('Tutorial'));
      await driver.waitFor(find.text('No character selected'));
    });
    
    test('Character creation works', () async {
      // open drawer
      await driver.tap(drawerButton);
      await driver.waitFor(createCharacter);
      // create a character
      await driver.tap(createCharacter);
      await driver.waitFor(find.text('Name'));
    });

    test('Editing works', () async {
      await driver.scroll(find.text('Name'), 0, 0, Duration(milliseconds: 500));
      await driver.waitFor(find.text('Basic info'));
      // enter name and description
      await driver.tap(find.text('Name'));
      await driver.enterText(ch1name);
      await driver.tap(find.text('Description'));
      await driver.enterText(ch1desc);
      await driver.tap(confirmButton);
      // confirm the change is saved
      await driver.waitForAbsent(find.text('Basic info'));
      await driver.waitFor(find.text(ch1name));
    });

    test('Persistence and active character swapping works', () async {
      // create a second character
      await driver.tap(drawerButton);
      await driver.tap(createCharacter);
      await driver.scroll(find.text('Name'), 0, 0, Duration(milliseconds: 500));
      await driver.waitFor(find.text('Basic info'));
      // enter a name & save
      await driver.tap(find.text('Name'));
      await driver.enterText(ch2name);
      await driver.tap(find.text('Description'));
      await driver.enterText(ch2desc);
      await driver.tap(confirmButton);
      // swap back to first character
      await driver.tap(drawerButton);
      await driver.tap(find.text(ch1name));
      await driver.waitForAbsent(createCharacter);
      await driver.waitFor(find.text(ch1desc));
      // swap back to second character
      await driver.tap(drawerButton);
      await driver.tap(find.text(ch2name));
      await driver.waitForAbsent(createCharacter);
      await driver.waitFor(find.text(ch2desc));
    });

    test('Notes behave', () async {
      await driver.tap(find.byTooltip('Notes'));
      await driver.tap(find.byTooltip('Edit'));
      await driver.tap(find.byType('TextFormField'));
      await driver.enterText(loremIpsum.text);
      await driver.tap(find.byTooltip('Clear notes'));
      await driver.tap(find.text('Yes'));
      await driver.tap(find.byTooltip('Edit'));
      await driver.tap(find.byType('TextFormField'));
      await driver.enterText(loremIpsum.text);
      await driver.tap(find.byTooltip('Save'));
      await driver.tap(find.byTooltip('Stats'));
      await driver.waitFor(find.text(ch2name));
    });

    test('Character deletion works', () async {
      await driver.tap(deleteCharacter);
      await driver.waitFor(find.text('Really delete this character?'));
      await driver.tap(find.text('Yes'));
      await driver.waitFor(find.text('No character selected'));
    });
  });
}
