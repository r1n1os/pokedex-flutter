import 'package:dio/dio.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/urls.dart';

class PokemonService {
  Future<PokemonServiceResponse> executeRequestToGetAllPokemon(
      String? url) async {
    Dio dio = getIt<Dio>();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    try {
      Response response = await dio.get(url ?? Urls.getListOfAllPokemonUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PokemonServiceResponse(
            pokemonEntityList: PokemonEntity.fromList(response.data['results']),
            nextUrl: response.data['next']);
      } else {
        return PokemonServiceResponse(
            error: response.statusMessage, statusCode: response.statusCode);
      }
    } catch (ex) {
      return PokemonServiceResponse(dioException: ex as DioException);
    }
  }

  Future<PokemonServiceResponse> executeRequestToGetDetailsOfPokemon(
      String url) async {
    Dio dio = getIt<Dio>();
    DioException? dioException;
    Response response = await dio.get(url).catchError((dioError) {
      dioException = dioError;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PokemonServiceResponse(
          pokemonEntity: PokemonEntity.fromJson(response.data));
    } else {
      return PokemonServiceResponse(
          dioException: dioException,
          error: response.statusMessage,
          statusCode: response.statusCode);
    }
  }
}

class PokemonServiceResponse {
  List<PokemonEntity>? pokemonEntityList;
  PokemonEntity? pokemonEntity;
  DioException? dioException;
  String? error;
  int? statusCode;
  String? nextUrl;

  PokemonServiceResponse(
      {this.pokemonEntityList,
      this.pokemonEntity,
      this.dioException,
      this.error,
      this.statusCode,
      this.nextUrl});
}
