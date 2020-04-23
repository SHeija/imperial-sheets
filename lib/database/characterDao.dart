import 'package:imperial_sheets/models/character.dart';
import 'package:sembast/sembast.dart';
import 'database.dart';

class CharacterDao {
  //DB
  static const String folderName = "Characters";
  final _characterFolder = stringMapStoreFactory.store(folderName);
  final _activeFolder = StoreRef.main();

  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future<String> insertCharacter(Character character) async{
    await setActiveCharacter(character);
    return await _characterFolder.record(character.id).add(await _db, character.toJson());
  }

  Future<String> updateCharacter(Character character) async{
    final finder = Finder(filter: Filter.byKey(character.id));
    await _characterFolder.update(await _db, character.toJson(),finder: finder);
  }

  Future<void> delete(Character character) async{
    final finder = Finder(filter: Filter.byKey(character.id));
    await _characterFolder.delete(await _db, finder: finder);
    await _activeFolder.delete(await _db);
  }

  Future<void> deleteAll() async{
    await _characterFolder.delete(await _db);
    await _activeFolder.delete(await _db);
  }

  Future<List<Character>> getAllCharacters()async{
    final recordSnapshot = await _characterFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final character = Character.fromJson(snapshot.value);
      return character;
    }).toList();
  }

  Future<void> setActiveCharacter(Character character) async {
    await _activeFolder.delete(await _db);
    await _activeFolder.add(await _db, character.toJson());
    print('Set active character: '+character.name);
  }

  Future<Character> getActiveCharacter() async {
    final recordSnapshot = await _activeFolder.findFirst(await _db);
    return Character.fromJson(recordSnapshot.value);
  }
}