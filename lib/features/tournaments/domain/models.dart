import 'package:cloud_firestore/cloud_firestore.dart';

enum TournamentType {
  challenge,
  cup,
  regional,
  international,
  worlds,
} // enum des types de tournoi

enum TournamentResult {
  winner,
  finalist,
  top4,
  top8,
  top16,
  top32,
  top64,
  top128,
  top256,
  top512,
  top1024,
  top2048,
  outOfTop,
}

enum MatchOutcome { win, tie, loss } // enum résultats de match

enum RoundHistory {
  w('W', MatchOutcome.win),
  ww('WW', MatchOutcome.win),
  lww('LWW', MatchOutcome.win),
  wlw('WLW', MatchOutcome.win),
  bye('Bye', MatchOutcome.win),

  l('L', MatchOutcome.loss),
  ll('LL', MatchOutcome.loss),
  lwl('LWL', MatchOutcome.loss),
  wll('WLL', MatchOutcome.loss),

  t('T', MatchOutcome.tie),
  wlt('WLT', MatchOutcome.tie),
  lwt('LWT', MatchOutcome.tie),
  id('ID', MatchOutcome.tie);

  // Constructeur de l'enum
  const RoundHistory(this.code, this.outcome);
  final String code;
  final MatchOutcome outcome;

  // Renvoi valeur enum
  static RoundHistory fromCode(String code) {
    return RoundHistory.values.firstWhere((r) => r.code == code);
  }
}

class Deck {
  // Classe des decks
  const Deck({required this.name, required this.pokemonIds});

  final String name;
  final List<int> pokemonIds;

  Map<String, dynamic> toMap() {
    return {'name': name, 'pokemonIds': pokemonIds};
  }

  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      name: map['name'] as String,
      pokemonIds: List<int>.from(map['pokemonIds'] as List),
    );
  }
}

class Round {
  const Round({required this.opponent, required this.history});

  final Deck opponent;
  final RoundHistory history;

  MatchOutcome get outcome => history.outcome;

  Map<String, dynamic> toMap() {
    return {'opponent': opponent.toMap(), 'history': history.code};
  }

  factory Round.fromMap(Map<String, dynamic> map) {
    return Round(
      opponent: Deck.fromMap(Map<String, dynamic>.from(map['opponent'] as Map)),
      history: RoundHistory.fromCode(map['history'] as String),
    );
  }
}

class Tournament {
  const Tournament({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.deck,
    required this.result,
    required this.cps,

    this.rounds = const [],
  });

  final String id;
  final String name;
  final TournamentType type;
  final DateTime date;
  final Deck deck;
  final TournamentResult result;
  final int cps;
  final List<Round> rounds;

  MatchRecord get record {
    var wins = 0, losses = 0, ties = 0;

    for (final round in rounds) {
      switch (round.outcome) {
        case MatchOutcome.win:
          wins++;
        case MatchOutcome.loss:
          losses++;
        case MatchOutcome.tie:
          ties++;
      }
    }
    return MatchRecord(wins, losses, ties);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.name,
      'date': Timestamp.fromDate(date),
      'deck': deck.toMap(),
      'result': result.name,
      'cps': cps,
      'rounds': rounds.map((r) => r.toMap()).toList(),
    };
  }
}

class MatchRecord {
  const MatchRecord(this.wins, this.losses, this.ties);

  final int wins;
  final int losses;
  final int ties;

  @override
  String toString() => '$wins-$losses-$ties';
}
