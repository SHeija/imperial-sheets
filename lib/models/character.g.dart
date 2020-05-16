// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return Character()
    ..name = json['name'] as String ?? ''
    ..description = json['description'] as String ?? ''
    ..notes = json['notes'] as String ?? ''
    ..id = json['id'] as String ?? ''
    ..stats = (json['stats'] as List)
            ?.map((e) =>
                e == null ? null : Stat.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..talents = (json['talents'] as List)
            ?.map((e) =>
                e == null ? null : Talent.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..skills = (json['skills'] as List)
            ?.map((e) =>
                e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..aptitudes =
        (json['aptitudes'] as List)?.map((e) => e as String)?.toList() ?? []
    ..items =
        (json['items'] as List)?.map((e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))?.toList() ?? []
    ..weapons = (json['weapons'] as List)?.map((e) => e == null ? null : Weapon.fromJson(e as Map<String, dynamic>))?.toList() ?? []
    ..armors = (json['armors'] as List)?.map((e) => e == null ? null : Armor.fromJson(e as Map<String, dynamic>))?.toList() ?? []
    ..powers = (json['powers'] as List)?.map((e) => e == null ? null : Power.fromJson(e as Map<String, dynamic>))?.toList() ?? []
    ..xp = json['xp'] as int ?? 0
    ..spentXp = json['spentXp'] as int ?? 0
    ..hp = json['hp'] as int ?? 0
    ..currentHp = json['currentHp'] as int ?? 0
    ..fate = json['fate'] as int ?? 0
    ..currentFate = json['currentFate'] as int ?? 0
    ..corruption = json['corruption'] as int ?? 0
    ..insanity = json['insanity'] as int ?? 0
    ..fatigue = json['fatigue'] as int ?? 0;
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
      'powers': instance.powers?.map((e) => e?.toJson())?.toList(),
      'xp': instance.xp,
      'spentXp': instance.spentXp,
      'hp': instance.hp,
      'currentHp': instance.currentHp,
      'fate': instance.fate,
      'currentFate': instance.currentFate,
      'corruption': instance.corruption,
      'insanity': instance.insanity,
      'fatigue': instance.fatigue,
    };
