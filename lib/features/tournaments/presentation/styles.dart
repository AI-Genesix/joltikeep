import 'package:flutter/material.dart';
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

extension TournamentTypeStyle on TournamentType {
  Color get color => switch (this) {
    TournamentType.challenge => AppColors.challenge,
    TournamentType.cup => AppColors.cup,
    TournamentType.regional => AppColors.regional,
    TournamentType.international => AppColors.international,
    TournamentType.worlds => AppColors.international,
  };

  String get label => switch (this) {
    TournamentType.challenge => "Challenge",
    TournamentType.cup => "Cup",
    TournamentType.regional => "Régional",
    TournamentType.international => "International",
    TournamentType.worlds => "Mondiaux",
  };
}

extension MatchOutcomeStyle on MatchOutcome {
  Color get color => switch (this) {
    MatchOutcome.win => AppColors.win,
    MatchOutcome.tie => AppColors.tie,
    MatchOutcome.loss => AppColors.loss,
  };

  String get label => switch (this) {
    MatchOutcome.win => "Victoire",
    MatchOutcome.tie => "Égalité",
    MatchOutcome.loss => "Défaite",
  };
}

extension TournamentResultStyle on TournamentResult {
  String get label => switch (this) {
    TournamentResult.winner => "Vainqueur",
    TournamentResult.finalist => "Finaliste",
    TournamentResult.top4 => "Top 4",
    TournamentResult.top8 => "Top 8",
    TournamentResult.top16 => "Top 16",
    TournamentResult.top32 => "Top 32",
    TournamentResult.top64 => "Top 64",
    TournamentResult.top128 => "Top 128",
    TournamentResult.top256 => "Top 256",
    TournamentResult.top512 => "Top 512",
    TournamentResult.top1024 => "Top 1024",
    TournamentResult.top2048 => "Top 2048",
    TournamentResult.outOfTop => "Hors-classement",
  };
}