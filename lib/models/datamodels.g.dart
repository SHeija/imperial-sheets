// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Talent _$TalentFromJson(Map<String, dynamic> json) {
  return Talent(
    json['title'] as String,
    json['description'] as String,
    json['tier'] as int,
    (json['aptitudes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TalentToJson(Talent instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'tier': instance.tier,
      'aptitudes': instance.aptitudes,
    };

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return Skill(
    json['title'] as String,
    (json['aptitudes'] as List)?.map((e) => e as String)?.toList(),
    json['stage'] as int,
    json['stat'] as String,
  )..subSkill = json['subSkill'] as String;
}

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'title': instance.title,
      'stat': instance.stat,
      'subSkill': instance.subSkill,
      'stage': instance.stage,
      'aptitudes': instance.aptitudes,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
    json['amount'] as int,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'amount': instance.amount,
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) {
  return Weapon(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
    json['range'] as String,
    json['rateOfFire'] as String,
    json['damage'] as String,
    json['type'] as String,
    json['penetration'] as String,
    json['clip'] as String,
    json['reloadSpeed'] as String,
    json['special'] as String,
  )..amount = json['amount'] as int;
}

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'amount': instance.amount,
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
    (json['armor'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  )..amount = json['amount'] as int;
}

Map<String, dynamic> _$ArmorToJson(Armor instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'amount': instance.amount,
      'armor': instance.armor,
    };

Stat _$StatFromJson(Map<String, dynamic> json) {
  return Stat(
    json['name'] as String,
    json['short'] as String,
    json['value'] as int,
    json['stage'] as int,
    (json['aptitudes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'name': instance.name,
      'short': instance.short,
      'value': instance.value,
      'stage': instance.stage,
      'aptitudes': instance.aptitudes,
    };
