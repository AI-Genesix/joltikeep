import 'package:flutter/material.dart';
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

class SeasonHeader extends StatelessWidget {
  const SeasonHeader({
    super.key,
    required this.label,
    required this.isCurrent,
    required this.totalCps,
    required this.tournamentCount,
    required this.record,
  });

  final String label;
  final bool isCurrent;
  final int totalCps;
  final int tournamentCount;
  final MatchRecord record;

  @override
  Widget build(BuildContext context) {
    final rate = record.winRate;
    final rateText = rate == null ? '-' : '${(rate * 100).round()} %';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Icon(Icons.expand_more, size: 18),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCurrent ? AppColors.win : AppColors.loss,
                    ),
                    width: 8,
                    height: 8,
                  ),
                  SizedBox(width: 6),
                  Text(
                    isCurrent ? "En cours" : "Terminée",
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "$totalCps",
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(width: 12),
              Text(
                "CPs",
                style: TextStyle(color: AppColors.muted, fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _Stat(value: '$tournamentCount', label: 'Tournois'),
              ),
              Container(width: 1, height: 32, color: AppColors.line),
              Expanded(
                child: _Stat(value: '$record', label: 'Score'),
              ),
              Container(width: 1, height: 32, color: AppColors.line),
              Expanded(
                child: _Stat(value: rateText, label: 'Victoires'),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(8)),
            child: Text(
            "Statistiques non officielles, basées seulement sur les informations saisies par l'utilisateur. Des erreurs peuvent donc apparaître.",
            style: TextStyle(fontSize: 10, color: AppColors.muted, fontStyle: FontStyle.italic)
          ),)
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        Text(label, style: TextStyle(color: AppColors.muted, fontSize: 12)),
      ],
    );
  }
  // Column centrée : value en gras (22), label en gris (12)
}
