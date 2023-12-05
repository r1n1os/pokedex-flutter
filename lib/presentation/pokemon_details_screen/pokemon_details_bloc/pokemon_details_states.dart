import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/domain/data_model/pokemon_details_data_model.dart';
import 'package:pokedex/utils/enums/states_enums.dart';

class PokemonDetailsStates {
  PokemonEntity? pokemonEntity;
  List<PokemonDetailsDataModel>? pokemonDetailsDataModelList;
  String? error;
  int? statusCode;
  StatesEnums statesEnums;

  PokemonDetailsStates(
      {this.pokemonEntity,
      this.pokemonDetailsDataModelList,
      this.error,
      this.statusCode,
      required this.statesEnums});

  PokemonDetailsStates copyWith({
    pokemonEntity,
    pokemonDetailsDataModelList,
    error,
    statusCode,
    statesEnums,
  }) {
    return PokemonDetailsStates(
      pokemonEntity: pokemonEntity ?? this.pokemonEntity,
      pokemonDetailsDataModelList: pokemonDetailsDataModelList ?? this.pokemonDetailsDataModelList,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      statesEnums: statesEnums ?? this.statesEnums,
    );
  }
}
