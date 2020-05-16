import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
  test('Toggling stow works', (){
    final Item item = Item.blank();
    expect(item.stowed, false);
    item.toggleStow();
    expect(item.stowed, true);
  });

  test('Stowing affects weigh correctly', (){
    final Item item = Item.blank();
    expect(item.getWeight(), 0.5);
    item.stowed = true;
    expect(item.getWeight(), 0);
  });

  test('Amount affects weigh correctly', () {
    final Item item = Item.blank();
    expect(item.getWeight(), 0.5);
    item.amount = 5;
    expect(item.getWeight(), 2.5);
  });
}