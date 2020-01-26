import './datamodels.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character {
  String name, description;
  List<Talent> talents;
  List<Skill> skills;
  List<String> aptitudes;
  List<Item> items;
  List<Weapon> weapons;
  Armor armor;

  Character(this.name, this.description, this.talents, this.skills, this.aptitudes, this.items, this.armor);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}