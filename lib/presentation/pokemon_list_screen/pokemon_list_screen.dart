import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_events.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonListBloc _pokemonListBloc = getIt<PokemonListBloc>();

  @override
  void initState() {
    _pokemonListBloc.add(ExecuteRequestToGetListWithAllPokemon());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: BlocProvider(
        create: (providerContext) => _pokemonListBloc,
        child: _buildView(),
      ),
    );
  }

  Widget _buildView() {
    return BlocConsumer<PokemonListBloc, PokemonListStates>(
      listener: (providerContext, state) {},
      builder: (providerContext, state) {
        return _buildViewBasedOnState(providerContext, state);
      },
    );
  }

  Widget _buildViewBasedOnState(
      BuildContext providerContext, PokemonListStates state) {
    if (state.error != null) {
      return _buildErrorView(providerContext, state);
    }
    return _buildPokemonList(providerContext, state.pokemonEntityList ?? []);
  }

  Widget _buildErrorView(
      BuildContext providerContext, PokemonListStates state) {
    return Center(
      child: Text(state.error ?? ''),
    );
  }

  Widget _buildPokemonList(BuildContext providerContext, List<PokemonEntity> pokemonEntityList) {
    return GridView.builder(
        itemCount: pokemonEntityList.length,
        itemBuilder: (context, index) {
      return _pokemonCard(pokemonEntityList[index]);
    }, gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    ),);
  }

  Widget _pokemonCard(PokemonEntity pokemonEntity) {
    print('Stats: ${pokemonEntity.statsEntityList?.length}');
    print('Type: ${pokemonEntity.pokemonTypeEntityList?.length}');
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) =>
            const CircularProgressIndicator(),
            imageUrl: pokemonEntity.photoUrl ?? '',
          ),
        ],
      ),
    );
  }
}
