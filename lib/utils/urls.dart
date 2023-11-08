import 'package:dio/dio.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class Urls {
  final String _baseUrl = 'https://pokeapi.co/api/v2/';

  Future<void> initializeDio() async {
    getIt.get<Dio>().options.baseUrl = _baseUrl;
  }

  static const getListOfAllPokemonUrl = 'pokemon/';
}
