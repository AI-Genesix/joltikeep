import 'package:flutter/material.dart';
import 'package:joltikeep/app/theme.dart';

class SeasonHeader extends StatelessWidget {
  const SeasonHeader({
    super.key,
    required this.label,
    required this.isCurrent,
    required this.totalCps,
    required this.tournamentCount,
  });

  final String label;
  final bool isCurrent;
  final int totalCps;
  final int tournamentCount;

  @override
  Widget build(BuildContext context) {
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
                    const Icon(Icons.expand_more, size: 18,),
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
                  SizedBox(width: 6,),
                  Text(isCurrent ? "En cours" : "Terminée", style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w700),),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text("Championship Points", style: TextStyle(color: AppColors.muted, fontSize: 13),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "$totalCps",
                style: TextStyle(color: AppColors.accent,
  fontSize: 56,
  fontWeight: FontWeight.w700,
  height: 1,
  letterSpacing: -1,),
              ),
              const Text(
                "CPs",
                style: TextStyle(color: AppColors.muted, fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "$tournamentCount ${tournamentCount > 1 ? 'tournois' : 'tournoi'}", style: TextStyle(color: AppColors.muted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
