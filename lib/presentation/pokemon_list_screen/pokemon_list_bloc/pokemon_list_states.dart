import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/enums/states_enums.dart';

class PokemonListStates {
  List<PokemonEntity>? pokemonEntityList;
  String? error;
  int? statusCode;
  StatesEnums statesEnums;

  PokemonListStates({this.pokemonEntityList, this.error, this.statusCode, required this.statesEnums});

  PokemonListStates copyWith({
    pokemonEntityList,
    error,
    statusCode,
    statesEnums,
  }) {
    return PokemonListStates(
      pokemonEntityList: pokemonEntityList ?? this.pokemonEntityList,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      statesEnums: statesEnums ?? this.statesEnums,
    );
  }
}
