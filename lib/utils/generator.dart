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
  character.hp = 10;
  character.damage = 11;
  character.xp = 2000;
  character.spentXp = 1500;
  character.faith = 3;
  character.currentFaith = 3-1;
  character.insanity = 10;
  character.corruption = 0;
  character.fatigue = 0;
  character.armors.add(Armor.blank());

  return character;
}

List<Talent> generateTalents() {
  Talent quickDraw = Talent('Quick Draw', 'Halves time required to draw a weapon', 1)
  ..aptitudes = ['agility', 'finesse'];
  Talent sprint = Talent('Sprint', 'Sprints', 3)
  ..aptitudes = ['agility', 'fieldcraft'];
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
  Weapon hotShot = Weapon('Hot-shot laspistol', 'Shoots harder than laspistol', 4.0)
  ..range = '20m'
  ..rateOfFire = '1/2/-'
  ..type = 'Energy'
  ..penetration = '7'
  ..clip = '20'
  ..reloadSpeed = '2Full'
  ..special = 'Overheats';
  return [hotShot];
}