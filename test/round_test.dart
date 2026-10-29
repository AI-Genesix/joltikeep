import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

void main() {
  test('Round mapping', () {
    const round = Round(
      opponent: Deck(name: "HnS", pokemonIds: [781]),
      history: RoundHistory.wlw,
    );
    expect(round.toMap(), {
      'opponent': {
        'name': "HnS",
        'pokemonIds': [781],
      },
      'history': 'WLW',
    });
  });
  test('Bon outcome', () {
    const round = Round(
      opponent: Deck(name: "HnS", pokemonIds: [781]),
      history: RoundHistory.wlw,
    );
    expect(round.outcome, MatchOutcome.win);
  });
}
