import 'package:flutter/material.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/local_database/entities/stats_entity.dart';
import 'package:pokedex/utils/color_utils.dart';

class PokemonDetailsDataModel {
  PokemonEntity? pokemonEntity;
  StatsEntity? statsEntity;
  Color? backgroundColor;
  double? pokemonStatsValue;
  Color? pokemonStatsColor;
  PokemonDetailsViewType? pokemonDetailsViewType;

  PokemonDetailsDataModel(
      {this.pokemonEntity,
      this.statsEntity,
      this.backgroundColor,
      this.pokemonStatsValue,
      this.pokemonStatsColor,
      this.pokemonDetailsViewType});

  static Future<List<PokemonDetailsDataModel>> buildPokemonDetailsDataModel(
      PokemonEntity? pokemonEntity) async {
    List<PokemonDetailsDataModel> pokemonDetailsDataModelList = [];

    if (pokemonEntity != null) {
      pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
          pokemonEntity: pokemonEntity,
          backgroundColor: ColorUtils().getTypeColor(
              pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
          pokemonDetailsViewType: PokemonDetailsViewType.pokemonImage));

      pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
          pokemonEntity: pokemonEntity,
          backgroundColor: ColorUtils().getTypeColor(
              pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
          pokemonDetailsViewType: PokemonDetailsViewType.pokemonTypes));

      await Future.forEach(pokemonEntity.statsEntityList ?? [], (statsEntity) {
        pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
            pokemonEntity: pokemonEntity,
            statsEntity: statsEntity,
            backgroundColor: ColorUtils().getTypeColor(
                pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
            pokemonStatsValue: statsEntity?.baseStat?.toDouble() ?? 0.0 / 100,
            pokemonStatsColor: ColorUtils().getTypeColor(
                pokemonEntity.pokemonTypeEntityList?.first.name ?? ''),
            pokemonDetailsViewType: PokemonDetailsViewType.pokemonStats));
      });
    } else {
      ///TODO: Handle scenario where pokemon entity is null
    }

    return pokemonDetailsDataModelList;
  }
}

enum PokemonDetailsViewType { pokemonImage, pokemonTypes, pokemonStats }
