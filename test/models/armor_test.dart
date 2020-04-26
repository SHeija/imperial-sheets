import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/models/datamodels.dart';

void main() {
  test('Stow affects armor', (){
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
    expect(a.getLeftArm(), 0);
    expect(a.getRightArm(), 0);
    expect(a.getBody(), 0);
    expect(a.getRightLeg(), 0);
    expect(a.getLeftLeg(), 0);

  });
}