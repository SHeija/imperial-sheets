import './datamodels.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;

part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character {
  String name, description, notes, id;
  List<Stat> stats;
  List<Talent> talents;
  List<Skill> skills;
  List<String> aptitudes;
  List<Item> items;
  List<Weapon> weapons;
  List<Armor> armors;
  List<Power> powers;

  int xp = 0;
  int spentXp = 0;
  int hp = 0;
  int currentHp = 0;
  int faith = 0;
  int currentFaith = 0;
  int corruption = 0;
  int insanity = 0;
  int fatigue = 0;

  Character.blank() {
    name = 'Name';
    description = 'Description';
    notes = '';
    stats = statSheet();
    skills = skillSheet();
    talents = [];
    items = [];
    weapons = [];
    aptitudes = [];
    armors = [];
    powers = [];
  }

  Character();

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  // MISC
  int getFatigueTreshold() {
    int wpB = getStat(Constants.WP).getStatBonus();
    int tB = getStat(Constants.T).getStatBonus();
    return wpB + tB;
  }

  // oh lord why
  double getCarryLimit() {
    int B = getStat(Constants.S).getStatBonus()+getStat(Constants.T).getStatBonus();
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

  // STATS
  Stat getStat(String statName) {
    return stats.firstWhere((element) => element.name == statName);
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

  // SKILLS
  List<Skill> skillSheet() {
    List<Skill> _skills = [];
    Constants.SKILL_LIST.forEach((key, value) {
      _skills.add(Skill.notKnown(key, value));
    });
    return _skills;
  }

  void fillSkillList() {
    // remove mis-named
    skills
        .retainWhere((element) => Constants.ALL_SKILLS.contains(element.name));
    // Create "sheet"
    List<Skill> newSkills = skillSheet();
    // Replace
    skills.forEach((existing) {
      newSkills[newSkills.indexWhere((e) => e.name == existing.name)] =
          existing;
    });
    skills = newSkills;
  }

  void sortSkills() {
    skills.sort((a,b) => a.name.compareTo(b.name));
  }

  //ITEMS
  double getItemWeight() {
    double armorWT = armors.fold(0.0, (previousValue, element) => previousValue + element.getWeight());
    double itemWt = items.fold(0.0, (previousValue, element) => previousValue + element.getWeight());
    double weaponWT = weapons.fold(0.0, (previousValue, element) => previousValue + element.getWeight());
    return armorWT+itemWt+weaponWT;
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
                    current.getHead() > next.getHead() ? current : next)
                .getHead(),
            'Left Arm': armors
                .reduce((current, next) =>
                    current.getLeftArm() > next.getLeftArm() ? current : next)
                .getLeftArm(),
            'Right Arm': armors
                .reduce((current, next) =>
                    current.getRightArm() > next.getRightArm() ? current : next)
                .getRightArm(),
            'Body': armors
                .reduce((current, next) =>
                    current.getBody() > next.getBody() ? current : next)
                .getBody(),
            'Left Leg': armors
                .reduce((current, next) =>
                    current.getLeftLeg() > next.getLeftLeg() ? current : next)
                .getLeftLeg(),
            'Right Leg': armors
                .reduce((current, next) =>
                    current.getRightLeg() > next.getRightLeg() ? current : next)
                .getRightLeg()
          };
  }
}
