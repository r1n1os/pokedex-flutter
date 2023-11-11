import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/data_model/pokemon_list_data_model.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_events.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
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
    //_pokemonListBloc.add(QueryAllPokemonListFromLocalDatabase());
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
    if (state.statesEnums == StatesEnums.loading) {
      return Stack(
        children: [
          _buildPokemonList(
              providerContext, state.pokemonListDataModelList ?? []),
          Center(
            child: const CircularProgressIndicator(
              color: Colors.amberAccent,
            ),
          ),
        ],
      );
    }
    return _buildPokemonList(
        providerContext, state.pokemonListDataModelList ?? []);
  }

  Widget _buildErrorView(
      BuildContext providerContext, PokemonListStates state) {
    return Center(
      child: Text(state.error ?? ''),
    );
  }

  Widget _buildPokemonList(BuildContext providerContext,
      List<PokemonListDataModel> pokemonListDataModelList) {
    return GridView.builder(
      itemCount: pokemonListDataModelList.length,
      itemBuilder: (context, index) {
        if(index == pokemonListDataModelList.length - 1){
          _pokemonListBloc.add(ExecuteRequestToGetNextPokemonPageIfAvailable());
        }
        return _pokemonCard(pokemonListDataModelList[index]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }

  Widget _pokemonCard(PokemonListDataModel pokemonListDataModel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pokemonListDataModel.isFrontCardViewVisible =
              !pokemonListDataModel.isFrontCardViewVisible;
        });
      },
      child: FlipCard(
        fill: Fill.fillFront,
        front: Card(
          color: pokemonListDataModel.cardBackgroundColor,
          child: Column(
            children: [
              CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl: pokemonListDataModel.pokemonEntity?.photoUrl ?? '',
              ),
            ],
          ),
        ),
        back: Card(
          color: pokemonListDataModel.cardBackgroundColor,
          child: Column(
            children: [
              Text(
                pokemonListDataModel.pokemonEntity?.name ?? ''
              ),
              Text(
                  pokemonListDataModel.pokemonEntity?.pokemonTypeEntityList?.map((e) => e.name).join("\n") ?? ''
              ),
            ],
          ),
        ),
      ),
    );
  }
}
