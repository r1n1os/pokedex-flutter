import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/data/local_database/entities/pokemon_with_pokemon_type_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonTypeEntity)
class PokemonTypeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn? get name => text().nullable()();

}

class PokemonTypeEntity {
  int id = 0;
  String? name;

  PokemonTypeEntity({this.id = 0, this.name});

  PokemonTypeEntity.fromJson(Map<String, dynamic> json) {
    name = json['type']['name'];
  }

  static List<PokemonTypeEntity> fromList(List jsonArray) {
    return jsonArray.map((e) => PokemonTypeEntity.fromJson(e)).toList();
  }

  static Future<int> addPokemonTypeToDatabase(
      PokemonTypeEntity pokemonTypeEntity) async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await db.into(db.pokemonTypeTable).insertOnConflictUpdate(
        PokemonTypeTableCompanion(
            name: Value(pokemonTypeEntity.name)));
  }

  static Future<void> addListOfPokemonTypeToDatabase(
      List<PokemonTypeEntity> pokemonTypeEntityList, int pokemonId) async {
    await Future.forEach(pokemonTypeEntityList, (pokemonTypeEntity) async {
      if(pokemonTypeEntity.name != 'normal') {
        int pokemonTypeId = await addPokemonTypeToDatabase(pokemonTypeEntity);
        await PokemonWithPokemonTypeEntity.addPokemonWithPokemonTypeToDatabase(
            pokemonId, pokemonTypeId);
      }
    });
  }

  static Future<PokemonTypeEntity?> getPokemonTypeEntityBasedOnId(
      int id) async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await (db.select(db.pokemonTypeTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  static Future<void> deletePokemonType() async {
    AppDatabase db = getIt.get<AppDatabase>();
    await (db.delete(db.pokemonTypeTable)).go();
  }
}
