// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'description', 'weight', 'amount']);
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
  $checkKeys(json,
      requiredKeys: const ['name', 'description', 'weight', 'amount']);
  return Weapon(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
  )
    ..amount = json['amount'] as int
    ..stowed = json['stowed'] as bool
    ..range = json['range'] as String ?? ''
    ..rateOfFire = json['rateOfFire'] as String ?? ''
    ..damage = json['damage'] as String ?? ''
    ..type = json['type'] as String ?? ''
    ..penetration = json['penetration'] as String ?? ''
    ..clip = json['clip'] as String ?? ''
    ..reloadSpeed = json['reloadSpeed'] as String ?? ''
    ..special = json['special'] as String ?? '';
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
  $checkKeys(json, requiredKeys: const [
    'name',
    'description',
    'weight',
    'amount',
    'head',
    'leftArm',
    'rightArm',
    'body',
    'leftLeg',
    'rightLeg'
  ]);
  return Armor(
    json['name'] as String,
    json['description'] as String,
    (json['weight'] as num)?.toDouble(),
  )
    ..amount = json['amount'] as int
    ..stowed = json['stowed'] as bool
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
      'head': instance.head,
      'leftArm': instance.leftArm,
      'rightArm': instance.rightArm,
      'body': instance.body,
      'leftLeg': instance.leftLeg,
      'rightLeg': instance.rightLeg,
    };
