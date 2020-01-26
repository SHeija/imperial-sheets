import 'package:json_annotation/json_annotation.dart';

part 'datamodels.g.dart';

@JsonSerializable()
class Talent {
  String title, description;
  int rank;
  List<String> aptitudes;

  Talent(this.title, this.description, this.rank, this.aptitudes);
  Talent.blank(){
    title = '';
    description = '';
    rank = 1;
    aptitudes = [];
  }

  factory Talent.fromJson(Map<String, dynamic> json) => _$TalentFromJson(json);
  Map<String, dynamic> toJson() => _$TalentToJson(this);
}

@JsonSerializable()
class Skill {
  final String title, skill; // e.g Parry, Weapon Skill
  int stage;
  final List<String> aptitudes;

  Skill(this.title, this.aptitudes, this.stage, this.skill);
  Skill.notKnown(this.title, this.aptitudes, this.skill){
    stage = 0;
  }

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

}

@JsonSerializable()
class Item {
  String title, description;
  double weight;

  Item(this.title, this.description, this.weight);
  Item.blank(){
    title = '';
    description = '';
    weight = 0.5;
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Weapon extends Item{
  String range, rateOfFire, reloadSpeed, type, damage;

  Weapon(String title, String description, double weight, this.range, this.rateOfFire, this.reloadSpeed, this.type, this.damage) : super(title, description, weight);
  Weapon.blank() : super.blank() {
    range = '';
    rateOfFire = '-/-/-';
    reloadSpeed = '';
    type = '';
    damage = '1d10';
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