import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/equipment.dart';
import '../utils/constants.dart' as Constants;

void main() {

  test('Character init', (){
    final Character c = Character.blank();
    expect(c.name, 'Name');
    expect(c.description, 'Description');
    expect(c.notes, '');
    expect(c.stats.length, 10);
    expect(c.skills.length, 32);
    expect(c.talents.isEmpty, true);
    expect(c.powers.isEmpty, true);
    expect(c.weapons.isEmpty, true);
    expect(c.items.isEmpty, true);
    expect(c.armors.isEmpty, true);
    expect(c.aptitudes.length, 1);
    expect(c.aptitudes[0], 'general');
  });

  group('Import', () {
    test('has 10 stats after cleanup', () {
      final Character noStatsGiven = Character()
          ..skills = [];
      final Character twoStatsGiven = Character()
          ..stats = [
            Stat(Constants.AG, 'AG', 25, 0),
            Stat(Constants.WP, 'WP', 25, 0),
          ];
      noStatsGiven.importCleanup();
      twoStatsGiven.importCleanup();

      expect(noStatsGiven.stats.length, 10);
      expect(twoStatsGiven.stats.length, 10);
    });

    test('has 32 skills after cleanup', () {
      final Character noSkillsGiven = Character()
          ..stats = [];
      final Character twoSkillsGiven = Character()
          ..skills = [
            Skill(Constants.forbiddenLore, 1, Constants.INT),
            Skill(Constants.stealth, 0, Constants.AG),
          ];

      noSkillsGiven.importCleanup();
      twoSkillsGiven.importCleanup();

      expect(noSkillsGiven.skills.length, 32);
      expect(twoSkillsGiven.skills.length, 32);
    });
    
    test('Misnamed are deleted', (){
      final Skill stealth = Skill(Constants.stealth, 0, Constants.AG);
      final Skill fl = Skill('Förbidden Löre', 0, Constants.INT);
      final Stat agility = Stat(Constants.AG, 'AG', 25, 0);
      final Stat balls = Stat('Balls Skill', 'AG', 25, 0);
      final Character c = Character()
          ..skills = [
            stealth,
            fl,
          ]
          ..stats = [
            agility,
            balls,
          ];
      c.importCleanup();
      expect(c.stats.length, 10);
      expect(c.stats.contains(agility), true);
      expect(c.stats.contains(balls), false);
      expect(c.skills.length, 32);
      expect(c.skills.contains(stealth), true);
      expect(c.skills.contains(fl), false);
    });
  });
  group('Utils', () {
    test('Fatigue trashold works correctly', (){
      final Character c = Character()
          ..stats = [
            Stat(Constants.WP, 'WP', 40, 0),
            Stat(Constants.T, 'T', 20, 0),
          ];
      expect(c.getFatigueTreshold(), 6);
    });
    test('Get Stat', (){
      final Character c = Character()
        ..stats = [
          Stat(Constants.WP, 'WP', 40, 0),
          Stat(Constants.T, 'T', 20, 0),
        ];
      dynamic stat = c.getThisStat(Constants.WP);
      dynamic noStat = c.getThisStat(Constants.INT);
      expect(stat.name, Constants.WP);
      expect(noStat, null);
    });
    test('Sort skills works correctly', (){
      final Character c = Character()
        ..skills = [
          Skill(Constants.stealth, 0, Constants.AG),
          Skill('Förbidden Löre', 0, Constants.INT),
        ];
      expect(c.skills[0].name, Constants.stealth);
      c.sortSkills();
      expect(c.skills[0].name, 'Förbidden Löre');
    });
  });
  group('Items', (){
    final Character character = Character()
        ..items = [
          Item.blank()
          ..weight = 1.0,
          Item.blank()
          ..weight = 2.0,
        ]
        ..armors = [
          Armor.blank()
          ..weight = 1.0
          ..head = 5,
          Armor.blank()
          ..weight = 1.0
          ..head = 2,
          Armor.blank()
          ..weight = 1.0
          ..leftLeg = 5,
          Armor.blank()
          ..weight = 0.5
          ..head = 7
          ..stowed = true,
        ]
        ..weapons = [
          Weapon.blank()
          ..weight = 1.0,
          Weapon.blank()
          ..weight = 50.0
          ..stowed = true,
        ];

    test('Total weigh is calculated correctly', () {
      expect(character.getItemWeight(), 7.0);
    });

    test('Armor points are calculated correctly', () {
      Map<String, int> armorPoints = character.getArmorPoints();
      expect(armorPoints['Head'], 5);
      expect(armorPoints['Left Leg'], 5);
    });

  });
}
