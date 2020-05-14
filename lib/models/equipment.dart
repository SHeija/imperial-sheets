import 'package:json_annotation/json_annotation.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Item {
  @JsonKey(required: true)
  String name, description;

  @JsonKey(required: true)
  double weight;

  @JsonKey(required: true)
  int amount;

  bool stowed = false;

  Item(this.name, this.description, this.weight, this.amount);
  Item.blank(){
    name = '';
    description = '';
    weight = 0.5;
    amount=1;
  }

  void toggleStow(){
    stowed = !stowed;
  }

  double getWeight() {
    return stowed ? 0 : weight*amount;
  }

  String getAmountString() {
    switch (amount) {
      case 1:
        return '';
        break;
      default:
        return '($amount)';
        break;
    }
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Weapon extends Item{
  @JsonKey(defaultValue: '')
  String range, rateOfFire, damage, type, penetration, clip, reloadSpeed, special;

  Weapon(String name, String description, double weight) : super(name, description, weight, 1);
  Weapon.blank() : super.blank() {
    range = '';
    rateOfFire = '';
    damage = '';
    type = '';
    penetration = '';
    clip = '';
    reloadSpeed = '';
    special='';
  }

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}

@JsonSerializable()
class Armor extends Item {
  @JsonKey(required: true)
  int head, leftArm, rightArm, body, leftLeg, rightLeg;

  Armor(String name, String description, double weight) : super(name, description, weight, 1);
  Armor.blank() : super.blank() {
    head = 0;
    leftArm = 0;
    rightArm = 0;
    body = 0;
    leftLeg = 0;
    rightLeg = 0;
  }

  // this can't be head*amount, because you can only wear one at a time
  int getHead() {
    return stowed || amount == 0 ? 0 : head;
  }

  int getLeftArm() {
    return stowed || amount == 0 ? 0 : leftArm;
  }

  int getRightArm() {
    return stowed || amount == 0 ? 0 : rightArm;
  }

  int getBody() {
    return stowed || amount == 0 ? 0 : body;
  }

  int getLeftLeg() {
    return stowed || amount == 0 ? 0 : leftLeg;
  }

  int getRightLeg() {
    return stowed || amount == 0 ? 0 : rightLeg;
  }

  factory Armor.fromJson(Map<String, dynamic> json) => _$ArmorFromJson(json);
  Map<String, dynamic> toJson() => _$ArmorToJson(this);
}