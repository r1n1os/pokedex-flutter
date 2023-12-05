import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/remote/pokemon_list_services.dart';
import 'package:pokedex/domain/data_model/pokemon_list_data_model.dart';
import 'package:pokedex/domain/repository/pokemon_list_repository.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_events.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/error_handling.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListBloc extends Bloc<PokemonListEvents, PokemonListStates> {
  final PokemonListRepository _pokemonListRepository =
      getIt.get<PokemonListRepository>();

  PokemonListBloc(super.initialState) {
    on<ExecuteRequestToGetListWithAllPokemon>(
        _executeRequestToGetListWithAllPokemon);
    on<ExecuteRequestToGetDetailsOfEachPokemon>(
        _executeRequestToGetDetailsOfEachPokemon);
    on<QueryAllPokemonListFromLocalDatabase>(
        _queryAllPokemonListFromLocalDatabase);
    on<ExecuteRequestToGetNextPokemonPageIfAvailable>(
        _executeRequestToGetNextPokemonPageIfAvailable);
  }

  FutureOr<void> _queryAllPokemonListFromLocalDatabase(
      QueryAllPokemonListFromLocalDatabase event,
      Emitter<PokemonListStates> emit) async {
    List<PokemonEntity> pokemonEntityList =
        await _pokemonListRepository.queryAllPokemonFromLocalDatabase();
    emit(state.copyWith(
        pokemonListDataModelList:
            await PokemonListDataModel.buildPokemonListDataModelList(
                pokemonEntityList),
        statesEnums: StatesEnums.loaded));
  }

  FutureOr<void> _executeRequestToGetListWithAllPokemon(
      ExecuteRequestToGetListWithAllPokemon event,
      Emitter<PokemonListStates> emit) async {
    if (event.url == null) {
      emit(state.copyWith(statesEnums: StatesEnums.loading));
    }
    PokemonListServiceResponse pokemonListServiceResponse =
        await _pokemonListRepository
            .executeRequestToGetListWithAllPokemon(event.url);
    if (pokemonListServiceResponse.error == null &&
        pokemonListServiceResponse.dioException == null) {
      add(ExecuteRequestToGetDetailsOfEachPokemon(
          pokemonEntityList:
              List<PokemonEntity>.of(state.pokemonEntityList ?? [])
                ..addAll(pokemonListServiceResponse.pokemonEntityList ?? []),
          nextUrl: pokemonListServiceResponse.nextUrl));
    } else {
      ErrorHandling.handleErrorMessage(
          pokemonListServiceResponse.dioException,
          pokemonListServiceResponse.error,
          pokemonListServiceResponse.statusCode);
    }
  }

  /**
   * Because the api service we are using does not giving us the details of each pokemon
   * Instead is giving us another url to get the details we need to call for each pokemon the extra api call to get the details
   * */
  FutureOr<void> _executeRequestToGetDetailsOfEachPokemon(
      ExecuteRequestToGetDetailsOfEachPokemon event,
      Emitter<PokemonListStates> emit) async {
    List<PokemonEntity> tempPokemonEntityList = [];
    await Future.forEach(event.pokemonEntityList ?? [], (pokemonEntity) async {
      PokemonListServiceResponse pokemonListServiceResponse =
          await _pokemonListRepository
              .executeRequestToGetDetailsOfPokemon(pokemonEntity.extraInfoUrl);
      if (pokemonListServiceResponse.error != null) {
        ErrorHandling.handleErrorMessage(
            pokemonListServiceResponse.dioException,
            pokemonListServiceResponse.error,
            pokemonListServiceResponse.statusCode);
      }
      if (pokemonListServiceResponse.pokemonEntity != null) {
        tempPokemonEntityList.add(pokemonListServiceResponse.pokemonEntity!);
      }
    });
    emit(state.copyWith(
        pokemonListDataModelList:
            List<PokemonListDataModel>.of(state.pokemonListDataModelList ?? [])
              ..addAll(await PokemonListDataModel.buildPokemonListDataModelList(
                  tempPokemonEntityList)),
        nextUrl: event.nextUrl,
        statesEnums: StatesEnums.loaded));
  }

  FutureOr<void> _executeRequestToGetNextPokemonPageIfAvailable(
      ExecuteRequestToGetNextPokemonPageIfAvailable event,
      Emitter<PokemonListStates> emit) async {
    if (state.nextUrl != null) {
      add(ExecuteRequestToGetListWithAllPokemon(url: state.nextUrl));
    }
  }
}
