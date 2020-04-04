// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return Character(
    json['name'] as String,
    json['description'] as String,
    (json['stats'] as List)
        ?.map(
            (e) => e == null ? null : Stat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
    (json['weapons'] as List)
        ?.map((e) =>
            e == null ? null : Weapon.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['armor'] == null
        ? null
        : Armor.fromJson(json['armor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'stats': instance.stats?.map((e) => e?.toJson())?.toList(),
      'talents': instance.talents?.map((e) => e?.toJson())?.toList(),
      'skills': instance.skills?.map((e) => e?.toJson())?.toList(),
      'aptitudes': instance.aptitudes,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'weapons': instance.weapons?.map((e) => e?.toJson())?.toList(),
      'armor': instance.armor?.toJson(),
    };
