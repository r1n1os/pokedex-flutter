import 'package:flutter/material.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/local_database/entities/pokemon_type_entity.dart';
import 'package:pokedex/data/local_database/entities/stats_entity.dart';
import 'package:pokedex/utils/pokemon_type_utils.dart';

class PokemonDetailsDataModel {
  PokemonEntity? pokemonEntity;
  PokemonTypeEntity? pokemonTypeEntity;
  StatsEntity? statsEntity;
  Color? backgroundColor;
  PokemonDetailsViewType? pokemonDetailsViewType;

  PokemonDetailsDataModel(
      {this.pokemonEntity, this.pokemonTypeEntity, this.statsEntity, this.backgroundColor, this.pokemonDetailsViewType});

  static Future<List<PokemonDetailsDataModel>> buildPokemonDetailsDataModel(
      PokemonEntity? pokemonEntity) async {
    List<PokemonDetailsDataModel> pokemonDetailsDataModelList = [];

    if(pokemonEntity != null) {
      pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
        pokemonEntity: pokemonEntity,
        backgroundColor: PokemonTypeUtils().getTypeColor(
            pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
        pokemonDetailsViewType: PokemonDetailsViewType.pokemonImage));
      await Future.forEach(pokemonEntity.pokemonTypeEntityList ?? [], (pokemonTypeEntity) {
        pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
            pokemonEntity: pokemonEntity,
            pokemonTypeEntity: pokemonTypeEntity,
            backgroundColor: PokemonTypeUtils().getTypeColor(
                pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
            pokemonDetailsViewType: PokemonDetailsViewType.pokemonTypes
        ));
      });

      await Future.forEach(pokemonEntity.statsEntityList ?? [], (statsEntity) {
        pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
            pokemonEntity: pokemonEntity,
            statsEntity: statsEntity,
            backgroundColor: PokemonTypeUtils().getTypeColor(
                pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
            pokemonDetailsViewType: PokemonDetailsViewType.pokemonStats
        ));
      });
    } else {
      ///TODO: Handle scenario where pokemon entity is null
    }

    return pokemonDetailsDataModelList;
  }
}

enum PokemonDetailsViewType { pokemonImage, pokemonTypes, pokemonStats }
