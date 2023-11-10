import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/local_database/entities/pokemon_type_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonWithPokemonTypeEntity)
class PokemonWithPokemonTypeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get pokemonId => integer().references(PokemonTable, #id)();

  IntColumn get pokemonTypeId => integer().references(PokemonTypeTable, #id)();
}

class PokemonWithPokemonTypeEntity {
  int? pokemonId;
  int? pokemonTypeId;

  PokemonWithPokemonTypeEntity({this.pokemonId, this.pokemonTypeId});

  static Future<void> addPokemonWithPokemonTypeToDatabase(
      int pokemonId, int pokemonTypeId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await db.into(db.pokemonWithPokemonTypeTable).insertOnConflictUpdate(
        PokemonWithPokemonTypeTableCompanion(
            pokemonId: Value(pokemonId), pokemonTypeId: Value(pokemonTypeId)));
  }

  static Future<List<PokemonWithPokemonTypeEntity>>
      getListOfPokemonWithPokemonTypeBasedOnPokemonId(
          int pokemonId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await (db.select(db.pokemonWithPokemonTypeTable)
          ..where((tbl) => tbl.pokemonId.equals(pokemonId)))
        .get();
  }

  static Future<void> deletePokemonWithPokemonTypeBasedOnPokemonId(
      int pokemonId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    (db.delete(db.pokemonWithPokemonTypeTable)
          ..where((tbl) => tbl.pokemonId.equals(pokemonId)))
        .go;
  }
}
