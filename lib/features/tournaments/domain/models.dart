enum TournamentType { challenge, cup, regional, international, worlds } // enum des types de tournoi

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