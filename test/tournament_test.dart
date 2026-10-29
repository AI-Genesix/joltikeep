import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

void main() {
  test('Tournament conserve ses valeurs par défaut', () {
    final tournament = Tournament(
      id: "t1",
      name: "Régional Nice",
      type: TournamentType.regional,
      date: DateTime.parse("2026-10-17"),
      deck: Deck(name: "HnS", pokemonIds: [781]),
      result: TournamentResult.finalist,
      cps: 325,
    );
    expect(tournament.rounds, isEmpty);
  });
}
