import 'package:drift/drift.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
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

  static Future<void> addTypeToDatabase(PokemonTypeEntity pokemonTypeEntity) async {
    AppDatabase db = getIt.get<AppDatabase>();
    db.into(db.pokemonTypeTable).insertOnConflictUpdate(PokemonTypeTableCompanion(
      id: Value(pokemonTypeEntity.id),
      name: Value(pokemonTypeEntity.name)
    ));
  }
}
