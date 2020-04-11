import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/utils/generator.dart';

class CharacterModel extends ChangeNotifier{
  final Character _character = generateCharacter();

  void updateStats(Stat stat, int index){
    _character.stats[index] = stat;
    notifyListeners();
  }

  Character getCharacter() {
    return _character;
  }

  List<Stat> getStats() {
    return _character.stats;
  }
}