import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/custom_widgets/custom_loader.dart';
import 'package:pokedex/domain/data_model/pokemon_list_data_model.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_screen.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_events.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_bloc/pokemon_list_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/extentions.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/images.dart';

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
      backgroundColor: Colors.blueGrey,
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
          _buildPokemonList(providerContext, state.nextUrl,
              state.pokemonListDataModelList ?? []),
          const CustomLoader()
        ],
      );
    }
    return _buildPokemonList(
        providerContext, state.nextUrl, state.pokemonListDataModelList ?? []);
  }

  Widget _buildErrorView(
      BuildContext providerContext, PokemonListStates state) {
    return Center(
      child: Text(state.error ?? ''),
    );
  }

  Widget _buildPokemonList(BuildContext providerContext, String? nextUrl,
      List<PokemonListDataModel> pokemonListDataModelList) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: pokemonListDataModelList.length,
            (context, index) {
              if (index == pokemonListDataModelList.length - 1 &&
                  nextUrl != null) {
                _pokemonListBloc
                    .add(ExecuteRequestToGetNextPokemonPageIfAvailable());
              }
              return _pokemonCard(pokemonListDataModelList[index]);
            },
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
        SliverToBoxAdapter(
            child: pokemonListDataModelList.isNotEmpty
                ? const CustomLoader(
                    loadingHeight: 50,
                    loadingWidth: 50,
                  )
                : Container()),
      ],
    );
  }

  Widget _pokemonCard(PokemonListDataModel pokemonListDataModel) {
    return GestureDetector(
      onTap: () {
        context.pushNavigation(
          screenToNavigate: PokemonDetailsScreen(
            pokemonId: pokemonListDataModel.pokemonEntity?.id ?? -1,
            extraInfoUrl:
                pokemonListDataModel.pokemonEntity?.extraInfoUrl ?? '',
          ),
        );
      },
      child: Card(
        color: pokemonListDataModel.cardBackgroundColor,
        child: Column(
          children: [
            CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl: pokemonListDataModel.pokemonEntity?.photoUrl ?? '',
                errorWidget: (context, url, error) {
                  print("Issued url: ${url}");
                  return Column(
                    children: [
                      Image.asset(Images.emptyPokeballIcon),
                      const Text(
                        'Oups! Pokemon Escaped!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
