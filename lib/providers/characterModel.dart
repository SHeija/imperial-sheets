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
}
