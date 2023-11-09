import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/enums/states_enums.dart';

class PokemonListStates {
  List<PokemonEntity>? pokemonEntityList;
  String? error;
  int? statusCode;
  String? nextUrl;
  StatesEnums statesEnums;

  PokemonListStates({this.pokemonEntityList, this.error, this.statusCode, this.nextUrl, required this.statesEnums});

  PokemonListStates copyWith({
    pokemonEntityList,
    error,
    statusCode,
    nextUrl,
    statesEnums,
  }) {
    return PokemonListStates(
      pokemonEntityList: pokemonEntityList ?? this.pokemonEntityList,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      nextUrl: nextUrl ?? this.nextUrl,
      statesEnums: statesEnums ?? this.statesEnums,
    );
  }
}
