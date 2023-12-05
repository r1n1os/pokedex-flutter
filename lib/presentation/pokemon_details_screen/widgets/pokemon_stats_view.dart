import 'package:flutter/material.dart';
import 'package:pokedex/data/local_database/entities/stats_entity.dart';

class PokemonStatsView extends StatelessWidget {
  final StatsEntity? statsEntity;
  final Color? pokemonStatsColor;
  final double? pokemonStatsValue;

   const PokemonStatsView({super.key, this.statsEntity, this.pokemonStatsColor, this.pokemonStatsValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 21, top: 15),
        child: Row(
          children: [
            SizedBox(
                width: 100,
                child: Text(statsEntity?.name ?? '')),
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                     color: pokemonStatsColor?.withOpacity(0.2)),
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    width: pokemonStatsValue,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: pokemonStatsColor)),
              ],
            ),
          ],
        ));
  }
}
