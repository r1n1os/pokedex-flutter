import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonEntity)
class PokemonTable extends Table {
  IntColumn get id => integer()();

  TextColumn? get name => text().nullable()();

  TextColumn? get extraInfoUrl => text().nullable()();

  IntColumn? get order => integer().nullable()();

  TextColumn? get photoUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PokemonEntity {
  int id = 0;
  String? name;
  String? extraInfoUrl;
  int? order;
  String? photoUrl;

  PokemonEntity(
      {this.id = 0, this.name, this.extraInfoUrl, this.order, this.photoUrl});

  PokemonEntity.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    name = json['name'];
    extraInfoUrl = json['url'];
    order = json['order'];
    if(json['sprites'] != null) {
      photoUrl = json['sprites']['other']['official-artwork']['front_default'];
    }
  }

  static List<PokemonEntity> fromList(List jsonArray) {
    return jsonArray.map((e) => PokemonEntity.fromJson(e)).toList();
  }

  static Future<void> addSinglePokemonToDatabase(
      PokemonEntity pokemonEntity) async {
    AppDatabase db = getIt.get<AppDatabase>();
    db.into(db.pokemonTable).insertOnConflictUpdate(PokemonTableCompanion(
        id: Value(pokemonEntity.id),
        name: Value(pokemonEntity.name),
        extraInfoUrl: Value(pokemonEntity.extraInfoUrl),
        order: Value(pokemonEntity.order),
        photoUrl: Value(pokemonEntity.photoUrl)));
  }

  static Future<void> addPokemonListToDatabase(
      List<PokemonEntity> pokemonEntityList) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await Future.forEach(pokemonEntityList, (pokemonEntity) {
      addSinglePokemonToDatabase(pokemonEntity);
    });
  }

  static Future<List<PokemonEntity>> getListOfAllPokemon() async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await db.select(db.pokemonTable).get();
  }
}
