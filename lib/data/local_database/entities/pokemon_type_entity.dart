import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/data/local_database/entities/pokemon_with_pokemon_type_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

@UseRowClass(PokemonTypeEntity)
class PokemonTypeTable extends Table {
  IntColumn get id => integer()();

  TextColumn? get name => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PokemonTypeEntity {
  int id = 0;
  String? name;

  PokemonTypeEntity({this.id = 0, this.name});

  PokemonTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['slot'];
    name = json['type']['name'];
  }

  static List<PokemonTypeEntity> fromList(List jsonArray) {
    return jsonArray.map((e) => PokemonTypeEntity.fromJson(e)).toList();
  }

  static Future<void> addPokemonTypeToDatabase(
      PokemonTypeEntity pokemonTypeEntity) async {
    AppDatabase db = getIt.get<AppDatabase>();
    await db.into(db.pokemonTypeTable).insertOnConflictUpdate(
        PokemonTypeTableCompanion(
            id: Value(pokemonTypeEntity.id),
            name: Value(pokemonTypeEntity.name)));
  }

  static Future<void> addListOfPokemonTypeToDatabase(
      List<PokemonTypeEntity> pokemonTypeEntityList, int pokemonId) async {
    await Future.forEach(pokemonTypeEntityList, (pokemonTypeEntity) async {
      await PokemonWithPokemonTypeEntity.addPokemonWithPokemonTypeToDatabase(
          pokemonId, pokemonTypeEntity.id);
      await addPokemonTypeToDatabase(pokemonTypeEntity);
    });
  }

  static Future<PokemonTypeEntity?> getPokemonTypeEntityBasedOnId(
      int id) async {
    AppDatabase db = getIt.get<AppDatabase>();
    return await (db.select(db.pokemonTypeTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
}
