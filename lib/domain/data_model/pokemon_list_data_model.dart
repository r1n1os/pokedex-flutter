import 'package:flutter/material.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/utils/color_utils.dart';

class PokemonListDataModel {
  PokemonEntity? pokemonEntity;
  Color? cardBackgroundColor;

  PokemonListDataModel(
      {this.pokemonEntity,
      this.cardBackgroundColor});

  static Future<List<PokemonListDataModel>> buildPokemonListDataModelList(
      List<PokemonEntity> pokemonEntityList) async {
    List<PokemonListDataModel> pokemonListDataModelList = [];

    await Future.forEach(pokemonEntityList, (pokemonEntity) {
      pokemonListDataModelList.add(PokemonListDataModel(
          pokemonEntity: pokemonEntity,
          cardBackgroundColor: pokemonEntity.pokemonTypeEntityList != null &&
                  pokemonEntity.pokemonTypeEntityList?.isNotEmpty == true
              ? ColorUtils().getTypeColor(
                  pokemonEntity.pokemonTypeEntityList?.first.name ?? '')
              : null,
        ));
    });

    return pokemonListDataModelList;
  }
}
