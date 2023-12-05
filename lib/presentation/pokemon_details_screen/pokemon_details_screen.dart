import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/custom_widgets/custom_loader.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/data/local_database/entities/pokemon_type_entity.dart';
import 'package:pokedex/domain/data_model/pokemon_details_data_model.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_bloc.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_events.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_states.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/images.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final int? pokemonId;

  const PokemonDetailsScreen({super.key, required this.pokemonId});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen>
    with TickerProviderStateMixin {
  final PokemonDetailsBloc _pokemonDetailsBloc = getIt<PokemonDetailsBloc>();
  late AnimationController _animationController;

  @override
  void initState() {
    _pokemonDetailsBloc.add(ExecuteLocalQueryToGetPokemonDetailsById(
        pokemonId: widget.pokemonId ?? -1));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        _animationController.value = 50;
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: BlocProvider(
        create: (providerContext) => _pokemonDetailsBloc,
        child: _buildView(),
      ),
    );
  }

  Widget _buildView() {
    return BlocConsumer<PokemonDetailsBloc, PokemonDetailsStates>(
      listener: (providerContext, state) {},
      builder: (providerContext, state) {
        return Stack(
          children: [
            _buildViewBasedOnState(providerContext, state),
            if (state.statesEnums == StatesEnums.loading) const CustomLoader(),
          ],
        );
      },
    );
  }

  Widget _buildViewBasedOnState(
      BuildContext providerContext, PokemonDetailsStates state) {
    if (state.error != null) {
      return _buildErrorView(providerContext, state);
    }

    return _buildPokemonDetailsView(
        state.pokemonEntity, state.pokemonDetailsDataModelList ?? []);
  }

  Widget _buildErrorView(
      BuildContext providerContext, PokemonDetailsStates state) {
    return Column(
      children: [
        Image.asset(Images.emptyPokeballIcon),
        const Text('Sorry pokemon escaped!')
      ],
    );
  }

  Widget _buildPokemonDetailsView(PokemonEntity? pokemonEntity,
      List<PokemonDetailsDataModel> pokemonDetailsDataModeList) {
    return ListView.builder(
        itemCount: pokemonDetailsDataModeList.length,
        itemBuilder: (context, index) {
          return _buildViewSectionsPerViewState(
              pokemonDetailsDataModeList[index]);
        });
  }

  Widget _buildViewSectionsPerViewState(
      PokemonDetailsDataModel pokemonDetailsDataModel) {
    switch (pokemonDetailsDataModel.pokemonDetailsViewType) {
      case PokemonDetailsViewType.pokemonImage:
        {
          return _buildPokemonImageView(pokemonDetailsDataModel);
        }
      case PokemonDetailsViewType.pokemonTypes:
        {
          return _buildPokemonTypesView(pokemonDetailsDataModel);
        }
      case PokemonDetailsViewType.pokemonStats:
        {
          return _buildPokemonStatsView(pokemonDetailsDataModel);
        }
      default:
        {
          return Container();
        }
    }
  }

  Widget _buildPokemonImageView(
      PokemonDetailsDataModel pokemonDetailsDataModel) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CachedNetworkImage(
        width: 200,
        height: 200,
        placeholder: (context, url) => const CircularProgressIndicator(),
        imageUrl: pokemonDetailsDataModel.pokemonEntity?.photoUrl ?? '',
      ),
    );
  }

  Widget _buildPokemonTypesView(
      PokemonDetailsDataModel pokemonDetailsDataModel) {
    return Container(
      padding: const EdgeInsets.only(left: 21),
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pokemonDetailsDataModel
                  .pokemonEntity?.pokemonTypeEntityList?.length ??
              0,
          itemBuilder: (context, index) {
            PokemonTypeEntity? pokemonTypeEntity = pokemonDetailsDataModel
                .pokemonEntity?.pokemonTypeEntityList?[index];
            return Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: pokemonDetailsDataModel.backgroundColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(pokemonTypeEntity?.name?.toUpperCase() ?? '')));
          }),
    );
  }

  Widget _buildPokemonStatsView(
      PokemonDetailsDataModel pokemonDetailsDataModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 21, top: 15),
        child: Row(
          children: [
            SizedBox(
                width: 100,
                child: Text(pokemonDetailsDataModel.statsEntity?.name ?? '')),
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: pokemonDetailsDataModel.pokemonStatsColor
                          ?.withOpacity(0.2)),
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    width: pokemonDetailsDataModel.pokemonStatsValue,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: pokemonDetailsDataModel.pokemonStatsColor)),
              ],
            ),
          ],
        ));
  }
}
