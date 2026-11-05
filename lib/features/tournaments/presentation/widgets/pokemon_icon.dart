import 'package:flutter/material.dart';
import 'package:joltikeep/app/theme.dart';

class PokemonIcon extends StatelessWidget {
  const PokemonIcon({super.key, required this.pokemonId, this.size = 32});

  final int pokemonId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HSLColor.fromAHSL(
          1,
          (pokemonId * 47) % 360,
          0.6,
          0.75,
        ).toColor(),
        border: Border.all(color: AppColors.surface, width: 2),
      ),
      child: Text(
        '$pokemonId',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.background,
        ),
      ),
    );
  }
}
