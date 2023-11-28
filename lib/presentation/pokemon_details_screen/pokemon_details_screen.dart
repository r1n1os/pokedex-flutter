import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/custom_widgets/custom_loader.dart';
import 'package:pokedex/data/local_database/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_bloc.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_events.dart';
import 'package:pokedex/presentation/pokemon_details_screen/pokemon_details_bloc/pokemon_details_states.dart';
import 'package:pokedex/utils/custom_colors.dart';
import 'package:pokedex/utils/enums/states_enums.dart';
import 'package:pokedex/utils/get_it_initialization.dart';

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
      backgroundColor: Colors.black12,
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

    return _buildPokemonDetailsView(state.pokemonEntity);
  }

  Widget _buildErrorView(
      BuildContext providerContext, PokemonDetailsStates state) {
    return const Column(
      children: [Text('Sorry pokemon escaped!')],
    );
  }

  Widget _buildPokemonDetailsView(PokemonEntity? pokemonEntity) {
    return Container(
      color: CustomColors.steel,
      child: Column(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: pokemonEntity?.photoUrl ?? '',
          ),
          Text('Pokemon Type(s)'),

          SizedBox(height: 15),
          _buildStatuses(pokemonEntity)
        ],
      ),
    );
  }

  Widget _buildStatuses(PokemonEntity? pokemonEntity) {
   return LinearProgressIndicator(
      backgroundColor: Colors.orangeAccent,
      valueColor: AlwaysStoppedAnimation(Colors.blue),
      minHeight: 25,
    );
    /* return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 15),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: 100),
      builder: (BuildContext context, double value, Widget? child) {
        return LinearProgressIndicator(

          value: 50, backgroundColor: Colors.black, color: Colors.pink,);
      },
    );*/
  }
}
