import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

void main() {
  test('Deck conserve ses valeurs', () {
    const deck = Deck(name: "Hide 'n Sneak", pokemonIds: [781]);
    expect(deck.name, "Hide 'n Sneak");
    expect(deck.pokemonIds, [781]);
  });
  test('Vérification de toMap()', () {
    const deck = Deck(name: "Hide 'n Sneak", pokemonIds: [781]);
    expect(deck.toMap(), {
      'name': "Hide 'n Sneak",
      'pokemonIds': [781],
    });
  });
  test('Vérification de fromMap()', () {
    final map = {
      'name': "Hide 'n Sneak",
      'pokemonIds': <dynamic>[781],
    };
    final deck = Deck.fromMap(map);
    expect(deck.name, "Hide 'n Sneak");
    expect(deck.pokemonIds, [781]);
  });
}
