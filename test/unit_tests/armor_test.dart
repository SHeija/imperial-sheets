import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
  test('Stow affects armor correctly', (){
    final Armor a = Armor.blank()
        ..head = 7
        ..leftArm = 7
        ..rightArm = 7
        ..body = 7
        ..leftLeg = 7
        ..rightLeg = 7;

    expect(a.getHead(), 7);
    expect(a.getLeftArm(), 7);
    expect(a.getRightArm(), 7);
    expect(a.getBody(), 7);
    expect(a.getRightLeg(), 7);
    expect(a.getLeftLeg(), 7);

    a.stowed = true;

    expect(a.getHead(), 0);
    expect(a.head, 7);
    expect(a.getLeftArm(), 0);
    expect(a.leftArm, 7);
    expect(a.getRightArm(), 0);
    expect(a.rightArm, 7);
    expect(a.getBody(), 0);
    expect(a.body, 7);
    expect(a.getRightLeg(), 0);
    expect(a.rightLeg, 7);
    expect(a.getLeftLeg(), 0);
    expect(a.leftLeg, 7);
  });

  test('Amount does not affect armor', () {
    final Armor a = Armor.blank()
      ..head = 7
      ..leftArm = 7
      ..rightArm = 7
      ..body = 7
      ..leftLeg = 7
      ..rightLeg = 7;

    expect(a.getHead(), 7);
    expect(a.getLeftArm(), 7);
    expect(a.getRightArm(), 7);
    expect(a.getBody(), 7);
    expect(a.getRightLeg(), 7);
    expect(a.getLeftLeg(), 7);

    a.amount = 5;

    expect(a.getHead(), 7);
    expect(a.getLeftArm(), 7);
    expect(a.getRightArm(), 7);
    expect(a.getBody(), 7);
    expect(a.getRightLeg(), 7);
    expect(a.getLeftLeg(), 7);
  });
}