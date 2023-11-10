import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonWithStatsEntity)
class PokemonWithStatsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get statName => text()();

  IntColumn get pokemonId => integer()();
}

class PokemonWithStatsEntity {
  int id = 0;
  String? statName;
  int? pokemonId;

  PokemonWithStatsEntity(
      {this.id = 0, this.statName, this.pokemonId});

  static Future<void> addPokemonWithStatToDatabase(
      String statName, int pokemonId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await db.into(db.pokemonWithStatsTable).insertOnConflictUpdate(PokemonWithStatsTableCompanion(
        statName: Value(statName),
        pokemonId: Value(pokemonId)));
  }

  static Future<List<PokemonWithStatsEntity>> getListOfPokemonWithStatsBasedOnPokemonId(int pokemonId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await (db.select(db.pokemonWithStatsTable)
      ..where((tbl) => tbl.pokemonId.equals(pokemonId))).get();
  }

  static Future<void> deletePokemonWithStatsBasedOnPokemonId(int pokemonId) async {
    AppDatabase db = getIt.get<AppDatabase>();
    (db.delete(db.pokemonWithStatsTable)..where((tbl) => tbl.pokemonId.equals(pokemonId))).go;
  }
}