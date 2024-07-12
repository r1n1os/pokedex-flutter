import 'package:flutter/material.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';
import 'package:pokedex/data/local_database/entities/stats_entity.dart';

class PokemonStatsView extends StatelessWidget {
  final List<StatsEntity>? statsEntityList;
  final Color? pokemonStatsColor;

  const PokemonStatsView(
      {super.key,
      this.statsEntityList,
      this.pokemonStatsColor,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: statsEntityList?.length,
        itemBuilder: (BuildContext context, int index) {
          StatsEntity currentStats = statsEntityList![index];
          return Padding(
            padding: const EdgeInsets.only(left: 21, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 100,
                    child: Text(
                      currentStats.name ?? '',
                      textAlign: TextAlign.start,
                    )),
                SizedBox(
                  width: 233,
                  child: LinearPercentage(
                    currentPercentage: currentStats.baseStat?.toDouble() ?? 0,
                    maxPercentage: 200,
                    backgroundHeight: 4,
                    percentageHeight: 4,
                    leftRightText: LeftRightText.leftOnly,
                    showPercentageOnPercentageView: false,
                    percentageOnPercentageViewTextStyle:
                        const TextStyle(color: Colors.white),
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
            ),
          );
        },
      ),
    );
  }
}
