import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/remote/pokemon_list_services.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListRepository {
  final PokemonListService _pokemonListService =
  getIt.get<PokemonListService>();

  Future<PokemonListServiceResponse>
  executeRequestToGetListWithAllPokemon() async {
    PokemonListServiceResponse pokemonListServiceResponse =
    await _pokemonListService.executeRequestToGetAllPokemon();
    if (pokemonListServiceResponse.error != null) {
      print(
          "Error: ${pokemonListServiceResponse
              .error} with error code: ${pokemonListServiceResponse
              .statusCode}");
    } else {
      //_addPokemonListIntoLocalDatabase(pokemonListServiceResponse.pokemonEntityList ?? []);
    }
    return pokemonListServiceResponse;
  }

  Future<PokemonListServiceResponse> executeRequestToGetDetailsOfPokemon(
      String url) async {
    PokemonListServiceResponse pokemonListServiceResponse =
    await _pokemonListService.executeRequestToGetDetailsOfPokemon(url);
    if (pokemonListServiceResponse.error != null) {
      print(
          "Error: ${pokemonListServiceResponse
              .error} with error code: ${pokemonListServiceResponse
              .statusCode}");
    } else {
      await _addSinglePokemonIntoLocalDatabase(
          pokemonListServiceResponse.pokemonEntity);
      pokemonListServiceResponse.pokemonEntityList =
      await _queryAllPokemonFromLocalDatabase();
    }
    return pokemonListServiceResponse;
  }

  Future<void> _addSinglePokemonIntoLocalDatabase(
      PokemonEntity? pokemonEntity) async {
    if (pokemonEntity != null) {
      await PokemonEntity.addSinglePokemonToDatabase(pokemonEntity);
    }
  }

  Future<void> _addPokemonListIntoLocalDatabase(
      List<PokemonEntity> pokemonEntityList) async {
    await PokemonEntity.addPokemonListToDatabase(pokemonEntityList);
  }

  Future<List<PokemonEntity>> _queryAllPokemonFromLocalDatabase() async {
    return await PokemonEntity.getListOfAllPokemon();
  }
}
