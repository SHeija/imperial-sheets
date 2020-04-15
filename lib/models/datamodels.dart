import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;

part 'datamodels.g.dart';

@JsonSerializable()
class Talent {
  String title, description;
  int tier;
  List<String> aptitudes;

  Talent(this.title, this.description, this.tier, this.aptitudes);
  Talent.blank(){
    title = '';
    description = '';
    tier = 1;
    aptitudes = [];
  }

  factory Talent.fromJson(Map<String, dynamic> json) => _$TalentFromJson(json);
  Map<String, dynamic> toJson() => _$TalentToJson(this);
}

@JsonSerializable()
class Skill {
  String title, stat; // e.g Parry, Weapon Skill
  String subSkill;
  int stage;
  List<String> aptitudes;

  Skill(this.title, this.aptitudes, this.stage, this.stat);
  Skill.notKnown(this.title, this.aptitudes, this.stat){
    subSkill = '';
    stage = 0;
  }
  Skill.blank();

  String getBonusString() {
    switch (stage){
      case 0:
        return '-20';
        break;
      default:
        return ('+${(stage-1)*10}');
        break;
    }
  }

  int getBonus() {
    switch (stage){
      case 0:
        return -20;
        break;
      default:
        return (stage-1)*10;
        break;
    }
  }

  bool canHaveMultiple() {
    const multiples = [Constants.scholasticLore, Constants.forbiddenLore, Constants.commonLore, Constants.trade];
    return multiples.contains(title);
  }

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

}

@JsonSerializable()
class Item {
  String title, description;
  double weight;
  int amount;

  Item(this.title, this.description, this.weight, this.amount);
  Item.blank(){
    title = '';
    description = '';
    weight = 0.5;
    amount=1;
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Weapon extends Item{
  String range, rateOfFire, damage, type, penetration, clip, reloadSpeed, special;

  Weapon(String title, String description, double weight, this.range, this.rateOfFire, this.damage, this.type, this.penetration, this.clip, this.reloadSpeed, this.special) : super(title, description, weight, 1);
  Weapon.blank() : super.blank() {
    range = '';
    rateOfFire = '-/-/-';
    damage = '1d10';
    type = '';
    penetration = '';
    clip = '';
    reloadSpeed = '';
    special='';
  }

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}

@JsonSerializable()
class Armor {
  Map armor;

  Armor(this.armor);
  Armor.blank(){
    armor = {
      'head': 0,
      'leftArm': 0,
      'rightArm': 0,
      'body': 0,
      'leftLeg': 0,
      'rightLeg': 0
    };
  }

  factory Armor.fromJson(Map<String, dynamic> json) => _$ArmorFromJson(json);
  Map<String, dynamic> toJson() => _$ArmorToJson(this);
}

@JsonSerializable()
class Stat {
  String name; // "Agility"
  String short; // "AG"
  int value;
  int stage;
  List<String> aptitudes;

  Stat(this.name, this.short, this.value, this.stage, this.aptitudes);
  Stat.blank();

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);

  int getStatBonus() {
    return (value/10).floor();
  }
}