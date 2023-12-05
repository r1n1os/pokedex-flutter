import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonImageView extends StatelessWidget {
  final String? photoUrl;

   PokemonImageView({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CachedNetworkImage(
        width: 200,
        height: 200,
        placeholder: (context, url) => const CircularProgressIndicator(),
        imageUrl: photoUrl ?? '',
      ),
    );
  }
}
