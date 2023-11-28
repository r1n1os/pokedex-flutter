import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';

class PokemonDetailsRepository {

  Future<PokemonEntity?> executeLocalQueryToGetPokemonDetailsById(int pokemonId) async {
    PokemonEntity? pokemonEntity = await PokemonEntity.queryPokemonEntityById(pokemonId);
    return pokemonEntity;
  }
}