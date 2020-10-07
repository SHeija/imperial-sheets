import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imperial_sheets/models/character.dart';

class HiveProvider extends InheritedWidget {
  HiveProvider({Widget child}) : super(child: child);
  final Box characters = Hive.box<Character>('characters');
  final Box settings = Hive.box('settings');

  Character getActiveCharacter() {
    final String id = settings.get('activeCharacter');
    return characters.get(id);
  }

  void initializeSettings() {
    if (settings.get('initialized') == null) {
      settings.put('Auto exp calculation', false);
      settings.put('Display editing timestamps', false);
      settings.put('Hide Powers', false);
      settings.put('Keep screen on', false);
      //settings.put('Dark mode', false);
      settings.put('initialized', true);
    }
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HiveProvider of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType(aspect: HiveProvider);
}