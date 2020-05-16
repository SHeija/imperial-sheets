// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Talent _$TalentFromJson(Map<String, dynamic> json) {
  return Talent(
    json['name'] as String ?? '',
    json['description'] as String ?? '',
    json['tier'] as int ?? 0,
  )
    ..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList()
    ..cost = json['cost'] as int;
}

Map<String, dynamic> _$TalentToJson(Talent instance) => <String, dynamic>{
      'aptitudes': instance.aptitudes,
      'cost': instance.cost,
      'name': instance.name,
      'description': instance.description,
      'tier': instance.tier,
    };

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return Skill(
    json['name'] as String ?? '',
    json['stage'] as int ?? 0,
    json['stat'] as String ?? '',
  )
    ..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList()
    ..cost = json['cost'] as int
    ..subSkill = json['subSkill'] as String ?? '';
}

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'aptitudes': instance.aptitudes,
      'cost': instance.cost,
      'name': instance.name,
      'stat': instance.stat,
      'subSkill': instance.subSkill,
      'stage': instance.stage,
    };

Power _$PowerFromJson(Map<String, dynamic> json) {
  return Power()
    ..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList()
    ..cost = json['cost'] as int
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
      'aptitudes': instance.aptitudes,
      'cost': instance.cost,
      'name': instance.name,
      'description': instance.description,
      'action': instance.action,
      'focusPower': instance.focusPower,
      'range': instance.range,
      'sustained': instance.sustained,
      'effect': instance.effect,
      'subType': instance.subType,
    };

Stat _$StatFromJson(Map<String, dynamic> json) {
  return Stat(
    json['name'] as String ?? '',
    json['short'] as String ?? '',
    json['value'] as int ?? 0,
    json['stage'] as int ?? 0,
  )
    ..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList()
    ..cost = json['cost'] as int
    ..unnaturalBonus = json['unnaturalBonus'] as int ?? 0;
}

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'aptitudes': instance.aptitudes,
      'cost': instance.cost,
      'name': instance.name,
      'short': instance.short,
      'value': instance.value,
      'stage': instance.stage,
      'unnaturalBonus': instance.unnaturalBonus,
    };
