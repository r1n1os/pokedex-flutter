import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonWithPokemonTypeEntity)
class PokemonWithPokemonTypeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get pokemonId => integer()();

  IntColumn get pokemonTypeId => integer()();
}

class PokemonWithPokemonTypeEntity {
  int id = 0;
  int? pokemonId;
  int? pokemonTypeId;

  PokemonWithPokemonTypeEntity(
      {this.id = 0, this.pokemonId, this.pokemonTypeId});

  static Future<void> addPokemonWithPokemonTypeToDatabase(
      int pokemonId, int pokemonTypeId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await db.into(db.pokemonWithPokemonTypeTable).insertOnConflictUpdate(
        PokemonWithPokemonTypeTableCompanion(
            pokemonId: Value(pokemonId), pokemonTypeId: Value(pokemonTypeId)));
  }

  static Future<List<PokemonWithPokemonTypeEntity>>
      getListOfPokemonWithPokemonTypeBasedOnPokemonId(int pokemonId) async {
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
