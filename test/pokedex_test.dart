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

  const a = Pokemon(id: 1, name: 'A');
  const b = Pokemon(id: 2, name: 'B');
  const c = Pokemon(id: 3, name: 'C');

  group('toggleSelection', () {
    test('ajoute en conservant l\'ordre', () {
      final result = toggleSelection([a], b);
      expect(result.map((p) => p.id), [1, 2]);
    });

    test('refuse un troisième Pokémon', () {
      final result = toggleSelection([a, b], c);
      expect(result.map((p) => p.id), [1, 2]);
    });

    // retirer, et vérifier que la liste d'origine n'a pas changé
  });
}
