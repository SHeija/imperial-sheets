import 'package:flutter/material.dart';
import 'package:imperial_sheets/database/characterDao.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class CharacterModel extends ChangeNotifier {
  CharacterModel(){
    this._characterList = [];
    fetchCurrentCharacter();
    fetchCharacterList();
  }

  static final CharacterDao db = CharacterDao();
  Character _currentCharacter;
  List<Character> _characterList;

  // SAVE CHANGES TO DB
  Future saveCharacter() async {
    if (_currentCharacter.id == null) {
      _currentCharacter.id = _currentCharacter.name+DateTime.now().toIso8601String();
      await db.insertCharacter(_currentCharacter);
      await fetchCharacterList();
    } else {
      await db.updateCharacter(_currentCharacter);
      await fetchCharacterList();
    }
    notifyListeners();
  }

  // FETCH FROM DB
  Future fetchCurrentCharacter() async {
    _currentCharacter = await db.getActiveCharacter();
  }

  Future fetchCharacterList() async {
    _characterList = await db.getAllCharacters();
    notifyListeners();
  }
  
  // CHARACTER LIST
  List<Character> getAllCharacters() {
    return _characterList;
  }

  Future<void> setCurrentCharacter(Character character) async {
    _currentCharacter = character;
    await db.setActiveCharacter(character);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    _currentCharacter = null;
    await db.deleteAll();
    await fetchCharacterList();
  }
  
  // CHARACTER
  Character getCharacter() {
    return _currentCharacter;
  }
  
  void createNewCharacter() {
    _currentCharacter = Character.blank();
    notifyListeners();
  }

  Future<void> deleteCurrentCharacter() async {
    await db.delete(_currentCharacter);
    await fetchCharacterList();
    _currentCharacter = null;
    notifyListeners();
  }
  
  void updateInfo(Character character) {
    _currentCharacter.name = character.name;
    _currentCharacter.description = character.description;
    _currentCharacter.hp = character.hp;
    _currentCharacter.currentHp = character.currentHp;
    _currentCharacter.xp = character.xp;
    _currentCharacter.spentXp = character.spentXp;
    _currentCharacter.faith = character.faith;
    _currentCharacter.currentFaith = character.currentFaith;
    _currentCharacter.insanity = character.insanity;
    _currentCharacter.corruption = character.corruption;
    _currentCharacter.fatigue = character.fatigue;
    notifyListeners();
    saveCharacter();
  }

  // STATS
  List<Stat> getStats() {
    return _currentCharacter.stats;
  }

  void updateStats(Stat stat, int index) {
    _currentCharacter.stats[index] = stat;
    saveCharacter();
    notifyListeners();
  }

  // SKILLS
  List<Skill> getSkills() {
    return _currentCharacter.skills;
  }

  void updateSkills(Skill skill, int index) {
    _currentCharacter.skills[index] = skill;
    saveCharacter();
    notifyListeners();
  }

  void addSkill(Skill skill) {
    _currentCharacter.skills.add(skill);
    _currentCharacter.sortSkills();
    saveCharacter();
    notifyListeners();
  }

  void removeSkill(Skill skill) {
    _currentCharacter.skills.remove(skill);
    saveCharacter();
    notifyListeners();
  }

  // TALENTS

  List<Talent> getTalents() {
    return _currentCharacter.talents;
  }

  void updateTalents(Talent talent, int index) {
    _currentCharacter.talents[index] = talent;
    saveCharacter();
    notifyListeners();
  }

  void addTalent(Talent talent) {
    _currentCharacter.talents.add(talent);
    saveCharacter();
    notifyListeners();
  }

  void removeTalent(Talent talent) {
    _currentCharacter.talents.remove(talent);
    saveCharacter();
    notifyListeners();
  }

  // ARMOR
  List<Armor> getArmors() {
    return _currentCharacter.armors;
  }

  Map<String, int> getArmorPoints() {
    return _currentCharacter.getArmorPoints();
  }

  void updateArmors(Armor armor, int index) {
    _currentCharacter.armors[index] = armor;
    saveCharacter();
    notifyListeners();
  }

  void addArmor(Armor armor){
    _currentCharacter.armors.add(armor);
    saveCharacter();
    notifyListeners();
  }

  void removeArmor(Armor armor) {
    _currentCharacter.armors.remove(armor);
    saveCharacter();
    notifyListeners();
  }

  void toggleStowArmor(int index) {
    _currentCharacter.armors[index].toggleStow();
    saveCharacter();
    notifyListeners();
  }

  // WEAPONS
  List<Weapon> getWeapons() {
    return _currentCharacter.weapons;
  }

  void updateWeapons(Weapon weapon, int index) {
    _currentCharacter.weapons[index] = weapon;
    saveCharacter();
    notifyListeners();
  }

  void addWeapon(Weapon weapon) {
    _currentCharacter.weapons.add(weapon);
    saveCharacter();
    notifyListeners();
  }

  void removeWeapon(Weapon weapon) {
    _currentCharacter.weapons.remove(weapon);
    saveCharacter();
    notifyListeners();
  }

  void toggleStowWeapon(int index) {
    _currentCharacter.weapons[index].toggleStow();
    saveCharacter();
    notifyListeners();
  }

  // ITEMS
  List<Item> getItems() {
    return _currentCharacter.items;
  }

  void updateItems(Item item, int index) {
    _currentCharacter.items[index] = item;
    saveCharacter();
    notifyListeners();
  }

  void addItem(Item item) {
    _currentCharacter.items.add(item);
    saveCharacter();
    notifyListeners();
  }

  void removeItem(Item item) {
    _currentCharacter.items.remove(item);
    saveCharacter();
    notifyListeners();
  }

  void toggleStowItem(int index) {
    _currentCharacter.items[index].toggleStow();
    saveCharacter();
    notifyListeners();
  }
}
