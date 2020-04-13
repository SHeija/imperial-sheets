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
  Armor armor;

  int xp;
  int spentXp;
  int hp;
  int damage;
  int faith;
  int currentFaith;
  int corruption;
  int insanity;
  int fatigue;

  Character.empty();
  Character(this.name, this.description, this.stats, this.talents, this.skills, this.aptitudes, this.items, this.weapons, this.armor);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  Stat getStat(String statName) {
    return stats.firstWhere((element) => element.name == statName);
  }

  int getFatigueTreshold() {
    int wp = stats.firstWhere((element) => element.name == Constants.WP).value;
    int t = stats.firstWhere((element) => element.name == Constants.T).value;
    return (wp/10).floor() + (t/10).floor();
  }
}