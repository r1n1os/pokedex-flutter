import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/remote/pokemon_list_services.dart';
import 'package:pokedex/domain/repository/pokemon_list_repository.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_events.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListBloc extends Bloc<PokemonListEvents, PokemonListStates> {
  final PokemonListRepository _pokemonListRepository =
  getIt.get<PokemonListRepository>();

  PokemonListBloc(super.initialState) {
    on<ExecuteRequestToGetListWithAllPokemon>(
        _executeRequestToGetListWithAllPokemon);
    on<ExecuteRequestToGetDetailsOfEachPokemon>(
        _executeRequestToGetDetailsOfEachPokemon);
  }

  FutureOr<void> _executeRequestToGetListWithAllPokemon(
      ExecuteRequestToGetListWithAllPokemon event,
      Emitter<PokemonListStates> emit) async {
    emit(state.copyWith(statesEnums: StatesEnums.loading));
    PokemonListServiceResponse pokemonListServiceResponse =
    await _pokemonListRepository.executeRequestToGetListWithAllPokemon();
    if (pokemonListServiceResponse.error == null) {
      emit(state.copyWith(
          pokemonEntityList: pokemonListServiceResponse.pokemonEntityList,
          nextUrl: pokemonListServiceResponse.nextUrl,
          statesEnums: StatesEnums.loaded));
      add(ExecuteRequestToGetDetailsOfEachPokemon());
    } else {
      ///TODO: Handle the error
    }
  }

  /**
   * Because the api service we are using does not giving us the details of each pokemon
   * Instead is giving us another url to get the details we need to call for each pokemon the extra api call to get the details
   * */
  FutureOr<void> _executeRequestToGetDetailsOfEachPokemon(
      ExecuteRequestToGetDetailsOfEachPokemon event,
      Emitter<PokemonListStates> emit) async {
    await Future.forEach(state.pokemonEntityList ?? [], (pokemonEntity) async {
      PokemonListServiceResponse pokemonListServiceResponse =
      await _pokemonListRepository.executeRequestToGetDetailsOfPokemon(
          pokemonEntity.extraInfoUrl);
      if (pokemonListServiceResponse.error == null) {
        emit(state.copyWith(
            pokemonEntityList: pokemonListServiceResponse.pokemonEntityList,
            nextUrl: pokemonListServiceResponse.nextUrl,
            statesEnums: StatesEnums.loaded));
      } else {
        ///TODO: Handle the error
      }
    });
  }
}
