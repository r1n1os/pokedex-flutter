import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/remote/pokemon_services.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListRepository {
  final PokemonService _pokemonListService =
      getIt.get<PokemonService>();

  Future<PokemonServiceResponse> executeRequestToGetListWithAllPokemon(
      String? url) async {
    PokemonServiceResponse pokemonListServiceResponse =
        await _pokemonListService.executeRequestToGetAllPokemon(url);
    return pokemonListServiceResponse;
  }

  Future<void> _addPokemonListIntoLocalDatabase(
      List<PokemonEntity> pokemonEntityList) async {
    await PokemonEntity.addPokemonListToDatabase(pokemonEntityList);
  }

  Future<List<PokemonEntity>> queryAllPokemonFromLocalDatabase() async {
    return await PokemonEntity.getListOfAllPokemon();
  }
}
