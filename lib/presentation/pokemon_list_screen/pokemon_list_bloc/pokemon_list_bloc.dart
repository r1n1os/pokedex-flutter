import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_events.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';

class PokemonListBloc extends Bloc<PokemonListEvents, PokemonListStates> {
  PokemonListBloc(super.initialState);

}