import './datamodels.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;

part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character {
  String name, description;
  List<Stat> stats;
  List<Talent> talents;
  List<Skill> skills;
  List<String> aptitudes;
  List<Item> items;
  List<Weapon> weapons;
  List<Armor> armors;

  int xp;
  int spentXp;
  int hp;
  int damage;
  int faith;
  int currentFaith;
  int corruption;
  int insanity;
  int fatigue;

  Character.blank() {
    name = 'Name';
    description = 'Description';
    stats = statSheet();
    skills = skillSheet();
    talents = [];
    items = [];
    weapons = [];
    aptitudes = [];
    armors = [];
    xp = 0;
    spentXp = 0;
    hp = 0;
    damage = 0;
    faith = 0;
    currentFaith = 0;
    corruption = 0;
    insanity = 0;
    fatigue = 0;
  }

  Character(this.name, this.description, this.stats, this.talents, this.skills,
      this.aptitudes, this.items, this.weapons, this.armors);

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  // UTILS
  Stat getStat(String statName) {
    return stats.firstWhere((element) => element.name == statName);
  }

  int getFatigueTreshold() {
    int wpB = getStat(Constants.WP).getStatBonus();
    int tB = getStat(Constants.T).getStatBonus();
    return wpB + tB;
  }

  List<Skill> skillSheet() {
    List<Skill> _skills = [];
    Constants.SKILL_LIST.forEach((key, value) {
      _skills.add(Skill.notKnown(key, [], value));
    });
    return _skills;
  }

  List<Stat> statSheet() {
    List<Stat> _stats = [];
    Constants.STAT_LIST.forEach((key, value) {
      _stats.add(Stat(value, key, 25, 0, []));
    });
    return _stats;
  }

  void fillStatList() {
    // Remove mis-named
    stats.retainWhere((element) => Constants.ALL_STATS.contains(element.name));
    // Create "sheet"
    List<Stat> newStats = statSheet();
    // Replace
    stats.forEach((existing) {
      newStats[newStats.indexWhere((e) => e.name == existing.name)] = existing;
    });
    stats = newStats;
  }

  void fillSkillList() {
    // remove mis-named
    skills
        .retainWhere((element) => Constants.ALL_SKILLS.contains(element.title));
    // Create "sheet"
    List<Skill> newSkills = skillSheet();
    // Replace
    skills.forEach((existing) {
      newSkills[newSkills.indexWhere((e) => e.title == existing.title)] =
          existing;
    });
    skills = newSkills;
  }

  Map<String, int> getArmorPoints() {
    return armors.isEmpty
        ? {
            'Head': 0,
            'Left Arm': 0,
            'Right Arm': 0,
            'Body': 0,
            'Left Leg': 0,
            'Right Leg': 0
          }
        : {
            'Head': armors
                .reduce((current, next) =>
                    current.head > next.head ? current : next)
                .head,
            'Left Arm': armors
                .reduce((current, next) =>
                    current.leftArm > next.leftArm ? current : next)
                .leftArm,
            'Right Arm': armors
                .reduce((current, next) =>
                    current.rightArm > next.rightArm ? current : next)
                .rightArm,
            'Body': armors
                .reduce((current, next) =>
                    current.body > next.body ? current : next)
                .body,
            'Left Leg': armors
                .reduce((current, next) =>
                    current.leftLeg > next.leftLeg ? current : next)
                .leftLeg,
            'Right Leg': armors
                .reduce((current, next) =>
                    current.rightLeg > next.rightLeg ? current : next)
                .rightLeg
          };
  }
}
