import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/enums/states_enums.dart';

class PokemonDetailsStates {
  PokemonEntity? pokemonEntity;
  String? error;
  int? statusCode;
  StatesEnums statesEnums;

  PokemonDetailsStates(
      {this.pokemonEntity,
      this.error,
      this.statusCode,
      required this.statesEnums});

  PokemonDetailsStates copyWith({
    pokemonEntity,
    error,
    statusCode,
    statesEnums,
  }) {
    return PokemonDetailsStates(
      pokemonEntity: pokemonEntity ?? this.pokemonEntity,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      statesEnums: statesEnums ?? this.statesEnums,
    );
  }
}
