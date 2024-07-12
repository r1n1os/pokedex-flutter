import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/data/remote/pokemon_services.dart';
import 'package:pokedex/domain/repository/pokemon_details_repository.dart';
import 'package:pokedex/domain/repository/pokemon_list_repository.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_bloc.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_states.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';

final getIt = GetIt.instance;

class GetItInitialization {
  void setupGetIt() {
    getIt.registerLazySingleton(() => Dio());
    getIt.registerLazySingleton(() => AppDatabase());
    getIt.registerFactory<PokemonService>(() => PokemonService());
    getIt.registerFactory<PokemonListRepository>(() => PokemonListRepository());
    getIt.registerFactory<PokemonDetailsRepository>(() => PokemonDetailsRepository());
    getIt.registerFactory<PokemonListStates>(() => PokemonListStates(statesEnums: StatesEnums.initialization));
    getIt.registerFactory<PokemonDetailsStates>(() => PokemonDetailsStates(statesEnums: StatesEnums.initialization));
    getIt.registerFactory<PokemonListBloc>(
        () => PokemonListBloc(getIt<PokemonListStates>()));
    getIt.registerFactory<PokemonDetailsBloc>(
            () => PokemonDetailsBloc(getIt<PokemonDetailsStates>()));
  }
}
