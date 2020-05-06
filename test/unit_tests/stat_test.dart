import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/models/datamodels.dart';

void main() {
  test('Stats bonus is correct', () {
    final Stat stat = Stat.blank()
      ..value = 25;
    expect(stat.getStatBonus(), 2);
    stat.value = 40;
    expect(stat.getStatBonus(), 4);

    final Stat unnaturalStat = Stat.blank()
      ..value = 25
      ..unnaturalBonus = 3;
    expect(unnaturalStat.getStatBonus(), 5);
    expect(unnaturalStat.isUnnatural(), isTrue);
  });
}