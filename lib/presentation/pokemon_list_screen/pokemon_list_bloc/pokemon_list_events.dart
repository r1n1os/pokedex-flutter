import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';

abstract class PokemonListEvents {}

class ExecuteRequestToGetListWithAllPokemon extends PokemonListEvents {
  String? url;

  ExecuteRequestToGetListWithAllPokemon({this.url});
}

class ExecuteRequestToGetDetailsOfEachPokemon extends PokemonListEvents {
  List<PokemonEntity> pokemonEntityList;
  String? nextUrl;

  ExecuteRequestToGetDetailsOfEachPokemon(
      {required this.pokemonEntityList, this.nextUrl});
}

class QueryAllPokemonListFromLocalDatabase extends PokemonListEvents {}

class ExecuteRequestToGetNextPokemonPageIfAvailable extends PokemonListEvents {}
