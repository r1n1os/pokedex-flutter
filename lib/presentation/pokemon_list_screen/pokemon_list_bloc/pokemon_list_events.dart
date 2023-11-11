abstract class PokemonListEvents {}

class ExecuteRequestToGetListWithAllPokemon extends PokemonListEvents {
  String? url;

  ExecuteRequestToGetListWithAllPokemon({this.url});
}

class ExecuteRequestToGetDetailsOfEachPokemon extends PokemonListEvents {}

class QueryAllPokemonListFromLocalDatabase extends PokemonListEvents {}

class ExecuteRequestToGetNextPokemonPageIfAvailable extends PokemonListEvents {}