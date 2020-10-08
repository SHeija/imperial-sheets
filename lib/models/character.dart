import 'package:hive/hive.dart';

import './equipment.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;
import 'attributes.dart';

part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character extends HiveObject {
  @JsonKey(defaultValue: '')
  String name, description, notes, id;

  @JsonKey(defaultValue: [])
  List<Stat> stats;

  @JsonKey(defaultValue: [])
  List<Talent> talents;

  @JsonKey(defaultValue: [])
  List<Skill> skills;

  @JsonKey(defaultValue: [])
  List<String> aptitudes;

  @JsonKey(defaultValue: [])
  List<Item> items;

  @JsonKey(defaultValue: [])
  List<Weapon> weapons;

  @JsonKey(defaultValue: [])
  List<Armor> armors;

  @JsonKey(defaultValue: [])
  List<Power> powers;

  @JsonKey(defaultValue: 0)
  int xp = 0;

  @JsonKey(defaultValue: 0)
  int spentXp = 0;

  @JsonKey(defaultValue: 0)
  int hp = 0;

  @JsonKey(defaultValue: 0)
  int currentHp = 0;

  @JsonKey(defaultValue: 0)
  int fate = 0;

  @JsonKey(defaultValue: 0)
  int currentFate = 0;

  @JsonKey(defaultValue: 0)
  int corruption = 0;

  @JsonKey(defaultValue: 0)
  int insanity = 0;

  @JsonKey(defaultValue: 0)
  int fatigue = 0;

  @JsonKey()
  DateTime lastEdited;

  Character.blank() {
    name = 'Name';
    description = 'Description';
    notes = '';
    stats = _statSheet();
    skills = _skillSheet();
    talents = [];
    items = [];
    weapons = [];
    aptitudes = ['general'];
    armors = [];
    powers = [];
    lastEdited = DateTime.now();
  }

  Character();

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  @override
  Future<void> save() {
    lastEdited = DateTime.now();
    return super.save();
  }

  // IMPORT

  void importCleanup() {
    id = DateTime.now().toIso8601String();
    lastEdited = lastEdited != null ? lastEdited : DateTime.now();
    _fillSkillList();
    _fillStatList();
  }

  List<Stat> _statSheet() {
    List<Stat> _stats = [];
    Constants.STAT_LIST.forEach((key, value) {
      _stats.add(Stat(value, key, 25, 0));
    });
    return _stats;
  }

  void _fillStatList() {
    // Remove mis-named
    if (stats == null) {
      stats = [];
    }
    stats.retainWhere((element) => Constants.ALL_STATS.contains(element.name));
    // Create "sheet"
    List<Stat> newStats = _statSheet();
    // Replace
    stats.forEach((existing) {
      newStats[newStats.indexWhere((e) => e.name == existing.name)] = existing;
    });
    stats = newStats;
  }

  List<Skill> _skillSheet() {
    List<Skill> _skills = [];
    Constants.SKILL_LIST.forEach((key, value) {
      _skills.add(Skill.notKnown(key, value));
    });
    return _skills;
  }

  void _fillSkillList() {
    if (skills == null) {
      skills = [];
    }
    // remove mis-named
    skills
        .retainWhere((element) => Constants.ALL_SKILLS.contains(element.name));
    // Create "sheet"
    List<Skill> newSkills = _skillSheet();
    // Replace
    skills.forEach((imported) {
      // handle multiples
      if (imported.canHaveMultiple() &&
          imported.subSkill != '' &&
          imported.subSkill != null) {
        newSkills.add(imported);
      } else {
        newSkills[newSkills.indexWhere((e) => e.name == imported.name)] =
            imported;
      }
    });
    skills = newSkills;
    sortSkills();
  }

  // MISC
  int getFatigueTreshold() {
    int wpB = getThisStat(Constants.WP).getStatBonus();
    int tB = getThisStat(Constants.T).getStatBonus();
    return wpB + tB;
  }

  void autoCalcExp() {
    spentXp = calculateSpentExp();
  }

  int calculateSpentExp() {
    int statExp =
        stats.fold(0, (previousValue, element) => previousValue + element.cost);
    int skillExp = skills.fold(
        0, (previousValue, element) => previousValue + element.cost);
    int talentExp = talents.fold(
        0, (previousValue, element) => previousValue + element.cost);
    int powerExp = powers.fold(
        0, (previousValue, element) => previousValue + element.cost);
    return statExp + skillExp + talentExp + powerExp;
  }

  // oh lord why
  double getCarryLimit() {
    int B = getThisStat(Constants.S).getStatBonus() +
        getThisStat(Constants.T).getStatBonus();
    switch (B) {
      case 0:
        return 0.9;
        break;
      case 1:
        return 2.25;
        break;
      case 2:
        return 4.5;
        break;
      case 3:
        return 9;
        break;
      case 4:
        return 18;
        break;
      case 5:
        return 27;
        break;
      case 6:
        return 36;
        break;
      case 7:
        return 45;
        break;
      case 8:
        return 56;
        break;
      case 9:
        return 67;
        break;
      case 10:
        return 78;
        break;
      case 11:
        return 90;
        break;
      case 12:
        return 112;
        break;
      case 13:
        return 225;
        break;
      case 14:
        return 337;
        break;
      case 15:
        return 450;
        break;
      case 16:
        return 675;
        break;
      case 17:
        return 900;
        break;
      case 18:
        return 11350;
        break;
      case 19:
        return 1800;
        break;
      case 20:
        return 2250;
        break;
      default:
        return 2500;
    }
  }

  dynamic getThisStat(String statName) {
    return stats.firstWhere((element) => element.name == statName,
        orElse: () => null);
  }

  void sortSkills() {
    skills.sort((a, b) => a.name.compareTo(b.name));
  }

  void sortTalents() {
    talents.sort((a, b) => a.name.compareTo(b.name));
  }

  //ITEMS
  double getItemWeight() {
    double armorWT = armors.fold(
        0.0, (previousValue, element) => previousValue + element.getWeight());
    double itemWt = items.fold(
        0.0, (previousValue, element) => previousValue + element.getWeight());
    double weaponWT = weapons.fold(
        0.0, (previousValue, element) => previousValue + element.getWeight());
    return armorWT + itemWt + weaponWT;
  }

  Map<String, int> getArmorPoints() {
    return armors.isEmpty || armors == null
        ? {
            'Head': 0,
            'Left Arm': 0,
            'Right Arm': 0,
            'Body': 0,
            'Left Leg': 0,
            'Right Leg': 0
          }
        : {
            'Head': armors.fold(0, (previousValue, current) {
              if (current.stackable) {
                return current.getHead() + previousValue;
              } else {
                return current.getHead() > previousValue
                    ? current.getHead()
                    : previousValue;
              }
            }),
            'Left Arm': armors.fold(0, (previousValue, current) {
              if (current.stackable) {
                return current.getLeftArm() + previousValue;
              } else {
                return current.getLeftArm() > previousValue
                    ? current.getLeftArm()
                    : previousValue;
              }
            }),
            'Right Arm': armors.fold(0, (previousValue, current) {
              if (current.stackable) {
                return current.getRightArm() + previousValue;
              } else {
                return current.getRightArm() > previousValue
                    ? current.getRightArm()
                    : previousValue;
              }
            }),
            'Body': armors.fold(0, (previousValue, current) {
              if (current.stackable) {
                return current.getBody() + previousValue;
              } else {
                return current.getBody() > previousValue
                    ? current.getBody()
                    : previousValue;
              }
            }),
            'Left Leg': armors.fold(0, (previousValue, current) {
              if (current.stackable) {
                return current.getLeftLeg() + previousValue;
              } else {
                return current.getLeftLeg() > previousValue
                    ? current.getLeftLeg()
                    : previousValue;
              }
            }),
            'Right Leg': armors.fold(0, (previousValue, current) {
              if (current.stackable) {
                return current.getRightLeg() + previousValue;
              } else {
                return current.getRightLeg() > previousValue
                    ? current.getRightLeg()
                    : previousValue;
              }
            }),
          };
  }
}
