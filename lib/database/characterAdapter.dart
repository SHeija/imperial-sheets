import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:imperial_sheets/models/character.dart';

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final typeId = 1;

  @override
  Character read(BinaryReader reader) {
    var jsonString = reader.readString();
    return Character.fromJson(jsonDecode(jsonString));
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    var jsonString = jsonEncode(obj.toJson());
    writer.writeString(jsonString);
  }
}