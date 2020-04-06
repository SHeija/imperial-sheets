import '../models/character.dart';
import '../models/datamodels.dart';
import 'constants.dart' as Constants;

Character generateCharacter() {
  String name = 'Roth Havelock';
  String description = 'A dashing low-life rogue that dreams of being part of the elite that he was meant to be';
  List<Stat> stats = generateStats();
  List<Talent> talents = generateTalents();
  List<Skill> skills = generateSkills();
  List<String> aptitudes = generateAptitudes();
  List<Item> items = generateItems();
  List<Weapon> weapons = generateWeapons();
  Armor armor = generateArmor();

  Character character = Character(name, description, stats, talents, skills, aptitudes, items, weapons, armor);
  character.hp = 10;
  character.damage = 11;
  character.xp = 2000;
  character.spentXp = 1500;
  character.faith = 3;
  character.currentFaith = 3-1;
  character.insanity = 10;
  character.corruption = 0;
  character.fatigue = 0;

  return character;
}

List<Stat> generateStats() {
  List<Stat> stats = [];
  Constants.STAT_LIST.forEach((key, value) {
    stats.add(Stat(value, key, 25, 0, []));
  });
  return stats;
}

List<Talent> generateTalents() {
  Talent quickDraw = Talent('Quick Draw', 'Halves time required to draw a weapon', 1, ['agility', 'finesse']);
  Talent sprint = Talent('Sprint', 'Sprints', 3, ['agility', 'fieldcraft']);
  return [quickDraw, sprint];
}

List<Skill> generateSkills() {
  Skill stealth = Skill('Stealth', ['agility', 'fieldcraft'], 3, 'agility');
  Skill parry = Skill.notKnown('Parry', ['weapon skill', 'strength'], 'weapon skill');
  return [stealth, parry];
}

List<String> generateAptitudes() {
  return ['agility', 'finesse', 'ballistic skill', 'defence', 'offence', 'strength', 'weapon skill'];
}

List<Item> generateItems() {
  Item photoContacts = Item('Photo contacts', 'photo-contacts', 0.5);
  Item microBead = Item('Micro-bead', 'vox lol', 0.5);
  return [photoContacts, microBead];
}

List<Weapon> generateWeapons() {
  Weapon hotShot = Weapon('Hot-shot laspistol', 'Shoots harder than laspistol', 4.0, '20m', '1/2/-', '2Full', 'Energy', '1d10+4');
  return [hotShot];
}

Armor generateArmor() {
  Armor armor = Armor.blank();
  armor.armor['head'] = '5';
  return armor;
}