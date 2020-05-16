import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;
part 'attributes.g.dart';


abstract class Buyable {
  List<String> aptitudes = [];
  int cost = 0;
}

@JsonSerializable()
class Talent extends Buyable{
  @JsonKey(required: true)
  String name, description;

  @JsonKey(required: true)
  int tier;

  Talent(this.name, this.description, this.tier);
  Talent.blank(){
    name = '';
    description = '';
    tier = 0;
  }

  factory Talent.fromJson(Map<String, dynamic> json) => _$TalentFromJson(json);
  Map<String, dynamic> toJson() => _$TalentToJson(this);
}

@JsonSerializable()
class Skill extends Buyable {
  @JsonKey(required: true)
  String name, stat; // e.g Parry, Weapon Skill

  String subSkill;

  @JsonKey(required: true)
  int stage;

  Skill(this.name, this.stage, this.stat);
  Skill.notKnown(this.name, this.stat){
    subSkill = '';
    stage = 0;
  }
  Skill.blank() : super();

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
    const multiples = Constants.SKILLS_MULTIPLE;
    return multiples.contains(name);
  }

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

}

@JsonSerializable()
class Power extends Buyable {
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
class Stat extends Buyable {
  String name; // "Agility"
  String short; // "AG"
  int value;
  int stage;
  int unnaturalBonus = 0;

  Stat(this.name, this.short, this.value, this.stage);
  Stat.blank();

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);

  bool isUnnatural() {
    return unnaturalBonus > 0;
  }

  int getStatBonus() {
    return (value/10).floor()+unnaturalBonus;
  }
}