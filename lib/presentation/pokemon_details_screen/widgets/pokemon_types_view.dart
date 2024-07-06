import 'package:flutter/material.dart';
import 'package:pokedex/data/local_database/entities/pokemon_type_entity.dart';

class PokemonTypesView extends StatelessWidget {
  final List<PokemonTypeEntity>? pokemonTypeEntityList;
  final Color backgroundColor;

  const PokemonTypesView({super.key, required this.backgroundColor, this.pokemonTypeEntityList});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pokemonTypeEntityList?.length ??
                0,
            itemBuilder: (context, index) {
              PokemonTypeEntity? pokemonTypeEntity = pokemonTypeEntityList?[index];
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(pokemonTypeEntity?.name?.toUpperCase() ?? '')));
            }),
      ),
    );
  }
}
