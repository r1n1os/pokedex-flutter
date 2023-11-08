import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_events.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_states.dart';

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvents, PokemonDetailsStates> {
  PokemonDetailsBloc(super.initialState);

}