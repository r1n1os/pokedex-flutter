import 'package:flutter/material.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';
import 'package:pokedex/data/local_database/entities/stats_entity.dart';

class PokemonStatsView extends StatelessWidget {
  final StatsEntity? statsEntity;
  final Color? pokemonStatsColor;
  final double? pokemonStatsValue;

   const PokemonStatsView({super.key, this.statsEntity, this.pokemonStatsColor, this.pokemonStatsValue});

  @override
  Widget build(BuildContext context) {
    print("${(statsEntity?.baseStat?.toDouble() ?? 0) / 100}");
    return Padding(
        padding: const EdgeInsets.only(left: 21, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: 100,
                child: Text(statsEntity?.name ?? '', textAlign: TextAlign.start,)),
            SizedBox(
              width: 150,
              child: LinearPercentage(
                currentPercentage: 0.50,
                maxPercentage: 10,
                backgroundHeight: 20,
                percentageHeight: 20,
                leftRightText: LeftRightText.leftOnly,
                showPercentageOnPercentageView: false,
                percentageOnPercentageViewTextStyle: const TextStyle(color: Colors.white),
                             backgroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38,
                ),
                percentageDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pokemonStatsColor,
                ),
              ),
            ),
          ],
        ));
  }
}
