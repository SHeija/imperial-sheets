// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Talent _$TalentFromJson(Map<String, dynamic> json) {
  return Talent(
    json['name'] as String,
    json['description'] as String,
    json['tier'] as int,
  )..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TalentToJson(Talent instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'tier': instance.tier,
      'aptitudes': instance.aptitudes,
    };

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return Skill(
    json['name'] as String,
    json['stage'] as int,
    json['stat'] as String,
  )
    ..subSkill = json['subSkill'] as String
    ..aptitudes =
        (json['aptitudes'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'name': instance.name,
      'stat': instance.stat,
      'subSkill': instance.subSkill,
      'stage': instance.stage,
      'aptitudes': instance.aptitudes,
    };

Power _$PowerFromJson(Map<String, dynamic> json) {
  return Power()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..action = json['action'] as String
    ..focusPower = json['focusPower'] as String
    ..range = json['range'] as String
    ..sustained = json['sustained'] as String
    ..effect = json['effect'] as String
    ..subType = json['subType'] as String;
}

Map<String, dynamic> _$PowerToJson(Power instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'action': instance.action,
      'focusPower': instance.focusPower,
      'range': instance.range,
      'sustained': instance.sustained,
      'effect': instance.effect,
      'subType': instance.subType,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
    json['amount'] as int,
  )..stowed = json['stowed'] as bool;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'amount': instance.amount,
      'stowed': instance.stowed,
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) {
  return Weapon(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
  )
    ..amount = json['amount'] as int
    ..stowed = json['stowed'] as bool
    ..range = json['range'] as String
    ..rateOfFire = json['rateOfFire'] as String
    ..damage = json['damage'] as String
    ..type = json['type'] as String
    ..penetration = json['penetration'] as String
    ..clip = json['clip'] as String
    ..reloadSpeed = json['reloadSpeed'] as String
    ..special = json['special'] as String;
}

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'amount': instance.amount,
      'stowed': instance.stowed,
      'range': instance.range,
      'rateOfFire': instance.rateOfFire,
      'damage': instance.damage,
      'type': instance.type,
      'penetration': instance.penetration,
      'clip': instance.clip,
      'reloadSpeed': instance.reloadSpeed,
      'special': instance.special,
    };

Armor _$ArmorFromJson(Map<String, dynamic> json) {
  return Armor(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
    (json['armorPoints'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    json['stowed'] as bool,
  )
    ..amount = json['amount'] as int
    ..head = json['head'] as int
    ..leftArm = json['leftArm'] as int
    ..rightArm = json['rightArm'] as int
    ..body = json['body'] as int
    ..leftLeg = json['leftLeg'] as int
    ..rightLeg = json['rightLeg'] as int;
}

Map<String, dynamic> _$ArmorToJson(Armor instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'amount': instance.amount,
      'stowed': instance.stowed,
      'armorPoints': instance.armorPoints,
      'head': instance.head,
      'leftArm': instance.leftArm,
      'rightArm': instance.rightArm,
      'body': instance.body,
      'leftLeg': instance.leftLeg,
      'rightLeg': instance.rightLeg,
    };

Stat _$StatFromJson(Map<String, dynamic> json) {
  return Stat(
    json['name'] as String,
    json['short'] as String,
    json['value'] as int,
    json['stage'] as int,
  )..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'name': instance.name,
      'short': instance.short,
      'value': instance.value,
      'stage': instance.stage,
      'aptitudes': instance.aptitudes,
    };
