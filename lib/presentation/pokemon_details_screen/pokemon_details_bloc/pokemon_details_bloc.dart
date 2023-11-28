import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/domain/repository/pokemon_details_repository.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_events.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvents, PokemonDetailsStates> {
  final PokemonDetailsRepository _pokemonDetailsRepository =
      getIt.get<PokemonDetailsRepository>();

  PokemonDetailsBloc(super.initialState) {
    on<ExecuteLocalQueryToGetPokemonDetailsById>(
        _onExecuteLocalQueryToGetPokemonDetailsById);
  }

  FutureOr<void> _onExecuteLocalQueryToGetPokemonDetailsById(
      ExecuteLocalQueryToGetPokemonDetailsById event,
      Emitter<PokemonDetailsStates> emit) async {
    emit(state.copyWith(
        statesEnums: StatesEnums.loading
    ));
    PokemonEntity? pokemonEntity = await _pokemonDetailsRepository.executeLocalQueryToGetPokemonDetailsById(event.pokemonId);
    if(pokemonEntity != null) {
      emit(state.copyWith(
        pokemonEntity: pokemonEntity,
        statesEnums: StatesEnums.loaded
      ));
    }
  }
}
