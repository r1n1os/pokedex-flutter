import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonEntity)
class PokemonTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn? get name => text().nullable()();

  TextColumn? get extraInfoUrl => text().nullable()();
}

class PokemonEntity {
  int id = 0;
  String? name;
  String? extraInfoUrl;

  PokemonEntity({this.id = 0, this.name, this.extraInfoUrl});

  PokemonEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extraInfoUrl = json['url'];
  }

  static List<PokemonEntity> fromList(List jsonArray) {
    return jsonArray.map((e) => PokemonEntity.fromJson(e)).toList();
  }

  static Future<void> addPokemonListToDatabase(
      List<PokemonEntity> pokemonEntityList) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await Future.forEach(pokemonEntityList, (pokemonEntity) {
      db.into(db.pokemonTable).insert(PokemonTableCompanion(
          name: Value(pokemonEntity.name),
          extraInfoUrl: Value(pokemonEntity.extraInfoUrl)));
    });
  }

  static Future<List<PokemonEntity>> getListOfAllPokemon() async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await db.select(db.pokemonTable).get();
  }
}
