import 'package:imperial_sheets/models/character.dart';
import 'package:sembast/sembast.dart';
import 'database.dart';

class CharacterDao {
  //DB
  static const String folderName = "Characters";
  final _characterFolder = intMapStoreFactory.store(folderName);

  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future<int> insertCharacter(Character character) async{
    return await _characterFolder.add(await _db, character.toJson() );
  }

  Future updateCharacter(Character character) async{
    final finder = Finder(filter: Filter.byKey(character.id));
    await _characterFolder.update(await _db, character.toJson(),finder: finder);
  }

  Future delete(Character character) async{
    final finder = Finder(filter: Filter.byKey(character.id));
    await _characterFolder.delete(await _db, finder: finder);
  }

  Future deleteAll() async{
    await _characterFolder.delete(await _db);
  }

  Future<List<Character>> getAllCharacters()async{
    final recordSnapshot = await _characterFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final character = Character.fromJson(snapshot.value);
      return character;
    }).toList();
  }


}