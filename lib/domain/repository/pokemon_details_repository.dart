import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/remote/pokemon_services.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonDetailsRepository {
  final PokemonService _pokemonService = getIt.get<PokemonService>();

  Future<PokemonEntity?> executeLocalQueryToGetPokemonDetailsById(
      int pokemonId) async {
    PokemonEntity? pokemonEntity =
        await PokemonEntity.queryPokemonEntityById(pokemonId);
    return pokemonEntity;
  }

  Future<PokemonServiceResponse> executeRequestToGetDetailsOfPokemon(
      String url) async {
    PokemonServiceResponse pokemonListServiceResponse =
        await _pokemonService.executeRequestToGetDetailsOfPokemon(url);
    if (pokemonListServiceResponse.error == null) {
      await _addSinglePokemonIntoLocalDatabase(
          pokemonListServiceResponse.pokemonEntity);
    }
    return pokemonListServiceResponse;
  }

  Future<void> _addSinglePokemonIntoLocalDatabase(
      PokemonEntity? pokemonEntity) async {
    if (pokemonEntity != null) {
      await PokemonEntity.addSinglePokemonToDatabase(pokemonEntity);
    }
  }
}
