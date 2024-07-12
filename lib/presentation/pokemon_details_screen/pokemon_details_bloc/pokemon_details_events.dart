abstract class PokemonDetailsEvents {}

class ExecuteRequestToGetPokemonDetailsFromRemoteById extends PokemonDetailsEvents {
  final String extraInfoUrl;

  ExecuteRequestToGetPokemonDetailsFromRemoteById({
    required this.extraInfoUrl,
  });
}

class ExecuteLocalQueryToGetPokemonDetailsById extends PokemonDetailsEvents {
  final int pokemonId;

  ExecuteLocalQueryToGetPokemonDetailsById({required this.pokemonId});
}
