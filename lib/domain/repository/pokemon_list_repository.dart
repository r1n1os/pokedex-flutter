import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/remote/pokemon_list_services.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListRepository {
  final PokemonListService _pokemonListService =
      getIt.get<PokemonListService>();

  Future<PokemonListServiceResponse> executeRequestToGetListWithAllPokemon(
      String? url) async {
    PokemonListServiceResponse pokemonListServiceResponse =
        await _pokemonListService.executeRequestToGetAllPokemon(url);
    return pokemonListServiceResponse;
  }

  Future<PokemonListServiceResponse> executeRequestToGetDetailsOfPokemon(
      String url) async {
    PokemonListServiceResponse pokemonListServiceResponse =
        await _pokemonListService.executeRequestToGetDetailsOfPokemon(url);
    if (pokemonListServiceResponse.error == null) {
      /*  await _addSinglePokemonIntoLocalDatabase(
          pokemonListServiceResponse.pokemonEntity);
      pokemonListServiceResponse.pokemonEntityList =
      await queryAllPokemonFromLocalDatabase();*/
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

  Future<List<PokemonEntity>> queryAllPokemonFromLocalDatabase() async {
    return await PokemonEntity.getListOfAllPokemon();
  }
}
