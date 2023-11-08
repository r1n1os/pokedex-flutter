import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/remote/pokemon_list_services.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListRepository {
  final PokemonListService _pokemonListService = getIt.get<PokemonListService>();

  Future<PokemonListServiceResponse> executeRequestToGetListWithAllPokemon() async {
    PokemonListServiceResponse pokemonListServiceResponse = await _pokemonListService.executeRequestToGetAllPokemon();
    if(pokemonListServiceResponse.error != null) {
      print("Error: ${pokemonListServiceResponse.error} with error code: ${pokemonListServiceResponse.statusCode}");
    } else {
      _addPokemonListIntoLocalDatabase(pokemonListServiceResponse.pokemonEntityList ?? []);
    }
    return pokemonListServiceResponse;
  }

  Future<void> _addPokemonListIntoLocalDatabase(List<PokemonEntity> pokemonEntityList) async {
    await PokemonEntity.addPokemonListToDatabase(pokemonEntityList);
  }
}