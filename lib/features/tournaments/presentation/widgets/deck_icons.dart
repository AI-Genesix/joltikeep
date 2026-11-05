import 'package:flutter/material.dart';
import 'package:joltikeep/features/tournaments/presentation/widgets/pokemon_icon.dart';

class DeckIcons extends StatelessWidget {
  const DeckIcons({super.key, required this.pokemonIds});

  final List<int> pokemonIds;

  static const double _size = 32;
  static const double _step = 22;

  @override
  Widget build(BuildContext context) {
    final width = _size + (pokemonIds.length - 1) * _step;
    return SizedBox(
      width: width,
      height: _size,
      child: Stack(
        children: [
          for (var i = 0; i < pokemonIds.length; i++)
            Positioned(
              left: i * _step,
              child: PokemonIcon(pokemonId: pokemonIds[i], size: _size),
            ),
        ],
      ),
    );
  }
}
