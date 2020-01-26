// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return Character(
    json['name'] as String,
    json['description'] as String,
    (json['talents'] as List)
        ?.map((e) =>
            e == null ? null : Talent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['aptitudes'] as List)?.map((e) => e as String)?.toList(),
    (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['armor'] == null
        ? null
        : Armor.fromJson(json['armor'] as Map<String, dynamic>),
  )..weapons = (json['weapons'] as List)
      ?.map(
          (e) => e == null ? null : Weapon.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'talents': instance.talents?.map((e) => e?.toJson())?.toList(),
      'skills': instance.skills?.map((e) => e?.toJson())?.toList(),
      'aptitudes': instance.aptitudes,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'weapons': instance.weapons?.map((e) => e?.toJson())?.toList(),
      'armor': instance.armor?.toJson(),
    };
