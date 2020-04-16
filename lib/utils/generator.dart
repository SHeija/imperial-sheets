import '../models/character.dart';
import '../models/datamodels.dart';

Character generateCharacter() {
  Character character = Character.blank();
  character.name = 'Roth Havelock';
  character.description = 'A dashing low-life rogue that dreams of being part of the elite that he was meant to be';
  character.talents = generateTalents();
  character.aptitudes = generateAptitudes();
  character.items = generateItems();
  character.weapons = generateWeapons();
  character.armor = generateArmor();
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

List<Talent> generateTalents() {
  Talent quickDraw = Talent('Quick Draw', 'Halves time required to draw a weapon', 1, ['agility', 'finesse']);
  Talent sprint = Talent('Sprint', 'Sprints', 3, ['agility', 'fieldcraft']);
  return [quickDraw, sprint];
}

List<String> generateAptitudes() {
  return ['agility', 'finesse', 'ballistic skill', 'defence', 'offence', 'strength', 'weapon skill'];
}

List<Item> generateItems() {
  Item photoContacts = Item('Photo contacts', 'photo-contacts', 0.5, 1);
  Item microBead = Item('Micro-bead', 'vox lol', 0.5, 1);
  return [photoContacts, microBead];
}

List<Weapon> generateWeapons() {
  Weapon hotShot = Weapon('Hot-shot laspistol', 'Shoots harder than laspistol', 4.0, '20m', '1/2/-', '1d10+4', 'Energy', '7', '20', '2Full', 'Overheats');
  return [hotShot];
}

Armor generateArmor() {
  Armor armor = Armor.blank();
  armor.armor['head'] = 5;
  return armor;
}