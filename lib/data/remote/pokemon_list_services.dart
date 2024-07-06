import 'package:dio/dio.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/urls.dart';

class PokemonListService {
  Future<PokemonListServiceResponse> executeRequestToGetAllPokemon(
      String? url) async {
    Dio dio = getIt<Dio>();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    try {
      Response response = await dio.get(url ?? Urls.getListOfAllPokemonUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PokemonListServiceResponse(
            pokemonEntityList: PokemonEntity.fromList(response.data['results']),
            nextUrl: response.data['next']);
      } else {
        return PokemonListServiceResponse(
            error: response.statusMessage, statusCode: response.statusCode);
      }
    } catch (ex) {
      return PokemonListServiceResponse(dioException: ex as DioException);
    }
  }

  Future<PokemonListServiceResponse> executeRequestToGetDetailsOfPokemon(
      String url) async {
    Dio dio = getIt<Dio>();
    DioException? dioException;
    Response response = await dio.get(url).catchError((dioError) {
      dioException = dioError;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PokemonListServiceResponse(
          pokemonEntity: PokemonEntity.fromJson(response.data));
    } else {
      return PokemonListServiceResponse(
          dioException: dioException,
          error: response.statusMessage,
          statusCode: response.statusCode);
    }
  }
}

class PokemonListServiceResponse {
  List<PokemonEntity>? pokemonEntityList;
  PokemonEntity? pokemonEntity;
  DioException? dioException;
  String? error;
  int? statusCode;
  String? nextUrl;

  PokemonListServiceResponse(
      {this.pokemonEntityList,
      this.pokemonEntity,
      this.dioException,
      this.error,
      this.statusCode,
      this.nextUrl});
}
