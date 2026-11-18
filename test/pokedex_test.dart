import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/pokemon.dart';

void main() {
  test('Lecture valeurs dex', () {
    final pokedex = parsePokedex(
      File('assets/data/pokedex.json').readAsStringSync(),
    );
    expect(pokedex.firstWhere((p) => p.id == 25).name, "Pikachu");
  });
}
