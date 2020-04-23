// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return Character()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..notes = json['notes'] as String
    ..id = json['id'] as String
    ..stats = (json['stats'] as List)
        ?.map(
            (e) => e == null ? null : Stat.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..talents = (json['talents'] as List)
        ?.map((e) =>
            e == null ? null : Talent.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..skills = (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..aptitudes = (json['aptitudes'] as List)?.map((e) => e as String)?.toList()
    ..items = (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..weapons = (json['weapons'] as List)
        ?.map((e) =>
            e == null ? null : Weapon.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..armors = (json['armors'] as List)
        ?.map(
            (e) => e == null ? null : Armor.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..xp = json['xp'] as int
    ..spentXp = json['spentXp'] as int
    ..hp = json['hp'] as int
    ..currentHp = json['currentHp'] as int
    ..faith = json['faith'] as int
    ..currentFaith = json['currentFaith'] as int
    ..corruption = json['corruption'] as int
    ..insanity = json['insanity'] as int
    ..fatigue = json['fatigue'] as int;
}

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'notes': instance.notes,
      'id': instance.id,
      'stats': instance.stats?.map((e) => e?.toJson())?.toList(),
      'talents': instance.talents?.map((e) => e?.toJson())?.toList(),
      'skills': instance.skills?.map((e) => e?.toJson())?.toList(),
      'aptitudes': instance.aptitudes,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'weapons': instance.weapons?.map((e) => e?.toJson())?.toList(),
      'armors': instance.armors?.map((e) => e?.toJson())?.toList(),
      'xp': instance.xp,
      'spentXp': instance.spentXp,
      'hp': instance.hp,
      'currentHp': instance.currentHp,
      'faith': instance.faith,
      'currentFaith': instance.currentFaith,
      'corruption': instance.corruption,
      'insanity': instance.insanity,
      'fatigue': instance.fatigue,
    };
