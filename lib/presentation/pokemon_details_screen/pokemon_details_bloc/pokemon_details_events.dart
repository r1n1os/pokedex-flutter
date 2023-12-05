abstract class PokemonDetailsEvents {}

class ExecuteLocalQueryToGetPokemonDetailsById extends PokemonDetailsEvents {
  final int pokemonId;

  ExecuteLocalQueryToGetPokemonDetailsById({required this.pokemonId});
}
