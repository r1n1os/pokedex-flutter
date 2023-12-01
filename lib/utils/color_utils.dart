import 'package:flutter/material.dart';
import 'package:pokedex/utils/custom_colors.dart';

class ColorUtils {
  Color getTypeColor(String type) {
    switch (type) {
      case 'fighting': return CustomColors.fighting;
      case 'flying' : return CustomColors.flying;
      case 'poison' : return CustomColors.poison;
      case 'ground' : return CustomColors.ground;
      case 'rock' : return CustomColors.rock;
      case 'bug' : return CustomColors.bug;
      case 'ghost' : return CustomColors.ghost;
      case 'steel' : return CustomColors.steel;
      case 'fire' : return CustomColors.fire;
      case 'water' : return CustomColors.water;
      case 'grass' : return CustomColors.grass;
      case 'electric' : return CustomColors.electric;
      case 'psychic' : return CustomColors.psychic;
      case 'ice' : return CustomColors.ice;
      case 'dragon' : return CustomColors.dragon;
      case 'fairy' : return CustomColors.fairy;
      case 'dark' : return CustomColors.dark;
      default: return Colors.white;
    }
  }
}
