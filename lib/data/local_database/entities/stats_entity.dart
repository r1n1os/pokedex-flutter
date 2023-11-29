import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/data/local_database/entities/pokemon_with_stats_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(StatsEntity)
class StatsTable extends Table {
  TextColumn get name => text().nullable()();

  IntColumn get baseStat => integer().nullable()();

  ///The reason of using text as primary key is because api does not offer id
  ///And I wanted to avoid use autoincrement.
  @override
  Set<Column> get primaryKey => {name};
}

class StatsEntity {
  String? name = '';
  int? baseStat;

  StatsEntity({this.name = '', this.baseStat});

  StatsEntity.fromJson(Map<String, dynamic> json) {
    if (json['stat'] != null) {
      name = json['stat']['name'];
    }
    baseStat = json['base_stat'];
  }

  static List<StatsEntity> fromList(List jsonArray) {
    return jsonArray.map((e) => StatsEntity.fromJson(e)).toList();
  }

  static Future<void> addStatEntityToDatabase(StatsEntity statsEntity) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await db.into(db.statsTable).insertOnConflictUpdate(StatsTableCompanion(
        name: Value(statsEntity.name), baseStat: Value(statsEntity.baseStat)));
  }

  static Future<void> addStatEntityListToDatabase(
      List<StatsEntity> statsEntityList, int pokemonId) async {
    await Future.forEach(statsEntityList, (statsEntity) async {
      PokemonWithStatsEntity.addPokemonWithStatToDatabase(
          statsEntity.name ?? '', pokemonId);
      await addStatEntityToDatabase(statsEntity);
    });
  }

  static Future<StatsEntity?> getStatBasedOnName(String name) async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await (db.select(db.statsTable)
          ..where((tbl) => tbl.name.equals(name)))
        .getSingleOrNull();
  }
}
