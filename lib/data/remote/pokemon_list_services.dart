import 'package:dio/dio.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/urls.dart';

class PokemonListService {
  Future<PokemonListServiceResponse> executeRequestToGetAllPokemon() async {
    Dio dio = getIt<Dio>();
    Map<String, dynamic> headers = {};
    Response response = await dio.get(Urls.getListOfAllPokemonUrl);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PokemonListServiceResponse(pokemonEntityList: PokemonEntity.fromList(response.data['results']));
    } else {
      return PokemonListServiceResponse(error: response.statusMessage, statusCode: response.statusCode);
    }
  }
}

class PokemonListServiceResponse {
  List<PokemonEntity>? pokemonEntityList;
  String? error;
  int? statusCode;

  PokemonListServiceResponse({this.pokemonEntityList, this.error, this.statusCode});
}
