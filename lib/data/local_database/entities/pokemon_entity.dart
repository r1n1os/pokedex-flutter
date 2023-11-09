import 'dart:ffi';

import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonEntity)
class PokemonTable extends Table {
 IntColumn get id => integer()();

  TextColumn? get name => text().nullable()();

  TextColumn? get extraInfoUrl => text().nullable()();

  IntColumn? get order => integer().nullable()();

 @override
 Set<Column> get primaryKey => {id};
}

class PokemonEntity {
  int id = 0;
  String? name;
  String? extraInfoUrl;
  int? order;

  PokemonEntity({this.id = 0, this.name, this.extraInfoUrl, this.order});

  PokemonEntity.fromJson(Map<String, dynamic> json) {
    if(json['id'] != null) {
      id = json['id'];
    }
    name = json['name'];
    extraInfoUrl = json['url'];
    order = json['order'];
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
        order: Value(pokemonEntity.order)));
  }

  static Future<void> addPokemonListToDatabase(
      List<PokemonEntity> pokemonEntityList) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await Future.forEach(pokemonEntityList, (pokemonEntity) {
      db.into(db.pokemonTable).insert(PokemonTableCompanion(
          id: Value(pokemonEntity.id),
          name: Value(pokemonEntity.name),
          extraInfoUrl: Value(pokemonEntity.extraInfoUrl),
          order: Value(pokemonEntity.order)));
    });
  }

  static Future<List<PokemonEntity>> getListOfAllPokemon() async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await db.select(db.pokemonTable).get();
  }
}
