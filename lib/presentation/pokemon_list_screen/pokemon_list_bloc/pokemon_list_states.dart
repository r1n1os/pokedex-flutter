import 'package:pokedex/utils/enums/states_enums.dart';

class PokemonListStates {
  String? error;
  int? statusCode;
  StatesEnums statesEnums;

  PokemonListStates({this.error, this.statusCode, required this.statesEnums});

  PokemonListStates copyWith({
    error,
    statusCode,
    statesEnums,
  }) {
    return PokemonListStates(
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      statesEnums: statesEnums ?? this.statesEnums,
    );
  }
}
