import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/utils/generator.dart';

class CharacterModel extends ChangeNotifier {
  final Character _character = generateCharacter();

  Character getCharacter() {
    return _character;
  }

  void updateInfo(Character character) {
    _character.name = character.name;
    _character.description = character.description;
    _character.hp = character.hp;
    _character.damage = character.damage;
    _character.xp = character.xp;
    _character.spentXp = character.spentXp;
    _character.faith = character.faith;
    _character.currentFaith = character.currentFaith;
    _character.insanity = character.insanity;
    _character.corruption = character.corruption;
    _character.fatigue = character.fatigue;
    notifyListeners();
  }

  // STATS
  List<Stat> getStats() {
    return _character.stats;
  }

  void updateStats(Stat stat, int index) {
    _character.stats[index] = stat;
    notifyListeners();
  }

  // SKILLS
  List<Skill> getSkills() {
    return _character.skills;
  }

  void updateSkills(Skill skill, int index) {
    _character.skills[index] = skill;
    notifyListeners();
  }

  void addSkill(Skill skill) {
    _character.skills.add(skill);
    notifyListeners();
  }

  void removeSkill(Skill skill) {
    _character.skills.remove(skill);
    notifyListeners();
  }

  // WEAPONS
  List<Weapon> getWeapons() {
    return _character.weapons;
  }

  void updateWeapons(Weapon weapon, int index) {
    _character.weapons[index] = weapon;
    notifyListeners();
  }

  void addWeapon(Weapon weapon) {
    _character.weapons.add(weapon);
    notifyListeners();
  }

  void removeWeapon(Weapon weapon) {
    _character.weapons.remove(weapon);
    notifyListeners();
  }

  // ITEMS
  List<Item> getItems() {
    return _character.items;
  }

  void updateItems(Item item, int index) {
    _character.items[index] = item;
    notifyListeners();
  }

  void addItem(Item item) {
    _character.items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _character.items.remove(item);
    notifyListeners();
  }
}
