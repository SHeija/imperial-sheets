import 'package:imperial_sheets/models/character.dart';
import 'package:sembast/sembast.dart';
import 'database.dart';

class CharacterDao {
  //DB
  static const String folderName = "Characters";
  final _characterFolder = stringMapStoreFactory.store(folderName);
  final _activeFolder = StoreRef.main();

  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future<void> saveCharacter(Character character) async{
    return await _characterFolder.record(character.id).put(await _db, character.toJson());
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
    await _activeFolder.record('active').put(await _db, character.id);
    print('Set active character: '+character.name);
  }

  Future<Character> getActiveCharacter() async {
    final idSnapshot = await _activeFolder.record('active').get(await _db);
    final recordSnapshot = await _characterFolder.record(idSnapshot.value).get(await _db);
    return Character.fromJson(recordSnapshot);
  }
}