import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import '../utils/constants.dart' as Constants;

void main() {
  test('canHaveMultiple works correctly', (){
    final multiples = [];
    final truth = Constants.SKILLS_MULTIPLE;
    Constants.ALL_SKILLS.forEach((element) {
      final Skill skill = Skill(element, 2, 'stat');
      if (skill.canHaveMultiple()) {
        multiples.add(skill.name);
      };
    });
    multiples.forEach((element) {
      expect(truth.contains(element), isTrue);
    });
  });
}