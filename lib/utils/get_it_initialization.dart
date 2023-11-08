import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/data/local_database/appDatabase.dart';
import 'package:pokedex/data/remote/pokemon_list_services.dart';
import 'package:pokedex/domain/repository/pokemon_list_repository.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';

final getIt = GetIt.instance;

class GetItInitialization {
  void setupGetIt() {
    getIt.registerLazySingleton(() => Dio());
    getIt.registerLazySingleton(() => AppDatabase());
    getIt.registerFactory<PokemonListService>(() => PokemonListService());
    getIt.registerFactory<PokemonListRepository>(() => PokemonListRepository());
    getIt.registerFactory<PokemonListStates>(() => PokemonListStates(statesEnums: StatesEnums.initialization));
    getIt.registerFactory<PokemonListBloc>(
        () => PokemonListBloc(getIt<PokemonListStates>()));
  }
}
