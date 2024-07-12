import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/custom_widgets/custom_loader.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_bloc.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_events.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_states.dart';
import 'package:pokedex/presentation/pokemon_details_screen/widgets/pokemon_image_view.dart';
import 'package:pokedex/presentation/pokemon_details_screen/widgets/pokemon_stats_view.dart';
import 'package:pokedex/presentation/pokemon_details_screen/widgets/pokemon_types_view.dart';
import 'package:pokedex/utils/color_utils.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/images.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final int pokemonId;
  final String extraInfoUrl;

  const PokemonDetailsScreen(
      {super.key, required this.pokemonId, required this.extraInfoUrl});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen>
    with TickerProviderStateMixin {
  final PokemonDetailsBloc _pokemonDetailsBloc = getIt<PokemonDetailsBloc>();
  late AnimationController _animationController;

  @override
  void initState() {
    /*_pokemonDetailsBloc.add(ExecuteLocalQueryToGetPokemonDetailsById(
        pokemonId: widget.pokemonId));*/
    _pokemonDetailsBloc.add(ExecuteRequestToGetPokemonDetailsFromRemoteById(
        extraInfoUrl: widget.extraInfoUrl));
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
          child: _buildView()),
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
    if (state.error != null /*|| state.pokemonEntity == null*/) {
      return _buildErrorView(providerContext, state);
    }

    return _buildPokemonDetailsView(state.pokemonEntity);
  }

  Widget _buildErrorView(
      BuildContext providerContext, PokemonDetailsStates state) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildAppBar(null),
          SizedBox(height: 200,),
          Image.asset(Images.emptyPokeballIcon),
          const Text(
            'Oups! Pokemon Escaped!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonDetailsView(PokemonEntity? pokemonEntity) {
    Color colorBasedOnPokemonType = ColorUtils()
        .getTypeColor(pokemonEntity?.pokemonTypeEntityList?.first.name ?? '');
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 50),
      color: colorBasedOnPokemonType,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(pokemonEntity),
          Expanded(
            child: Stack(
              children: [
                _buildPokemonBasicDetails(
                    pokemonEntity, colorBasedOnPokemonType),
                if (pokemonEntity != null) _buildPokemonImage(pokemonEntity)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(PokemonEntity? pokemonEntity) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            const SizedBox(
              width: 21,
            ),
            Text(
              pokemonEntity != null
                  ? _pokemonDetailsBloc.state.pokemonEntity!.name
                          ?.toUpperCase() ??
                      ''
                  : '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonBasicDetails(
      PokemonEntity? pokemonEntity, Color colorBasedOnPokemonType) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
          top: MediaQuery.of(context).size.width / 2),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          PokemonTypesView(
            backgroundColor: colorBasedOnPokemonType,
            pokemonTypeEntityList: pokemonEntity?.pokemonTypeEntityList,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Base Stats',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorBasedOnPokemonType),
          ),
          if (pokemonEntity?.statsEntityList != null)
            PokemonStatsView(
              statsEntityList: pokemonEntity?.statsEntityList ?? [],
              pokemonStatsColor: colorBasedOnPokemonType,
            )
        ],
      ),
    );
  }

  Widget _buildPokemonImage(PokemonEntity? pokemonEntity) {
    return Padding(
      padding:
          EdgeInsets.only(top: 60, left: MediaQuery.of(context).size.width / 4),
      child: PokemonImageView(photoUrl: pokemonEntity?.photoUrl),
    );
  }
}
