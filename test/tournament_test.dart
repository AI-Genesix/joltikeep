import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

Round makeRound(RoundHistory h) => Round(
  opponent: const Deck(name: 'HnS', pokemonIds: [781]),
  history: h,
);

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
  test('Calcul du score de tournoi', () {
    final tournament = Tournament(
      id: "t1",
      name: "Régional Nice",
      type: TournamentType.regional,
      date: DateTime.parse("2026-10-17"),
      deck: Deck(name: "HnS", pokemonIds: [781]),
      result: TournamentResult.finalist,
      cps: 325,
      rounds: [
        makeRound(RoundHistory.ww),
        makeRound(RoundHistory.lww),
        makeRound(RoundHistory.ll),
        makeRound(RoundHistory.id),
        makeRound(RoundHistory.bye),
      ],
    );
    expect(tournament.record.toString(), "3-1-1");
  });
  test('Vérification toMap()', () {
    final tournament = Tournament(
      id: "t1",
      name: "Régional Nice",
      type: TournamentType.regional,
      date: DateTime.parse("2026-10-17"),
      deck: Deck(name: "HnS", pokemonIds: [781]),
      result: TournamentResult.finalist,
      cps: 325,
      rounds: [makeRound(RoundHistory.ww)],
    );
    expect(tournament.toMap(), {
      'name': "Régional Nice",
      'type': "regional",
      'date': Timestamp.fromDate(DateTime.parse('2026-10-17')),
      'deck': {
        'name': "HnS",
        "pokemonIds": [781],
      },
      'result': 'finalist',
      'cps': 325,
      'rounds': [
        {
          'opponent': {
            'name': "HnS",
            'pokemonIds': [781],
          },
          'history': 'WW',
        },
      ],
    });
  });
}
