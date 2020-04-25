import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;

part 'datamodels.g.dart';

@JsonSerializable()
class Talent {
  String name, description;
  int tier;
  List<String> aptitudes;

  Talent(this.name, this.description, this.tier);
  Talent.blank(){
    name = '';
    description = '';
    tier = 0;
    aptitudes = [];
  }

  factory Talent.fromJson(Map<String, dynamic> json) => _$TalentFromJson(json);
  Map<String, dynamic> toJson() => _$TalentToJson(this);
}

@JsonSerializable()
class Skill {
  String name, stat; // e.g Parry, Weapon Skill
  String subSkill;
  int stage;
  List<String> aptitudes;

  Skill(this.name, this.stage, this.stat);
  Skill.notKnown(this.name, this.stat){
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
    const multiples = [Constants.scholasticLore, Constants.forbiddenLore, Constants.commonLore, Constants.trade, Constants.linguistics];
    return multiples.contains(name);
  }

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

}

@JsonSerializable()
class Power {
  String name, description, action, focusPower, range, sustained, effect, subType;

  Power();
  Power.blank(){
    name = '';
    description = '';
    action = '';
    focusPower = '';
    range = '';
    sustained = '';
    effect = '';
    subType = '';
  }

  factory Power.fromJson(Map<String, dynamic> json) => _$PowerFromJson(json);
  Map<String, dynamic> toJson() => _$PowerToJson(this);
}

@JsonSerializable()
class Item {
  String name, description;
  double weight;
  int amount;
  bool stowed = false;

  Item(this.name, this.description, this.weight, this.amount);
  Item.blank(){
    name = '';
    description = '';
    weight = 0.5;
    amount=1;
  }

  void toggleStow(){
    stowed = !stowed;
  }

  double getWeight() {
    return stowed ? 0 : weight*amount;
  }

  String getAmountString() {
    switch (amount) {
      case 1:
        return '';
        break;
      default:
        return '($amount)';
        break;
    }
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Weapon extends Item{
  String range, rateOfFire, damage, type, penetration, clip, reloadSpeed, special;

  Weapon(String name, String description, double weight) : super(name, description, weight, 1);
  Weapon.blank() : super.blank() {
    range = '';
    rateOfFire = '';
    damage = '';
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
class Armor extends Item {
  Map<String, int> armorPoints;
  int head, leftArm, rightArm, body, leftLeg, rightLeg;

  Armor(String name, String description, double weight, this.armorPoints, bool stowed) : super(name, description, weight, 1);
  Armor.blank() : super.blank() {
    stowed = false;
    head = 0;
    leftArm = 0;
    rightArm = 0;
    body = 0;
    leftLeg = 0;
    rightLeg = 0;
  }

  int getHead() {
    return stowed || amount == 0 ? 0 : head;
  }

  int getLeftArm() {
    return stowed || amount == 0 ? 0 : leftArm;
  }

  int getRightArm() {
    return stowed || amount == 0 ? 0 : rightArm;
  }

  int getBody() {
    return stowed || amount == 0 ? 0 : body;
  }

  int getLeftLeg() {
    return stowed || amount == 0 ? 0 : leftLeg;
  }

  int getRightLeg() {
    return stowed || amount == 0 ? 0 : rightLeg;
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

  Stat(this.name, this.short, this.value, this.stage);
  Stat.blank();

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);

  int getStatBonus() {
    return (value/10).floor();
  }
}