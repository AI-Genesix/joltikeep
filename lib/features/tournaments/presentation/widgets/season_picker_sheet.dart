import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/providers.dart';

class SeasonPickerSheet extends ConsumerWidget {
  const SeasonPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasons = ref.watch(seasonsProvider);
    final displayedId = ref
        .watch(displayedSeasonProvider)
        .maybeWhen(data: (s) => s?.id, orElse: () => null);
    return Container(
      padding: const EdgeInsets.all(16),
      child: seasons.when(
        data: (list) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Choisir une saison :")],
            ),
            for (final s in list) ...[
              ListTile(
                title: displayedId == s.id
                    ? Row(
                        children: [
                          Text(s.label),
                          SizedBox(width: 6),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.win,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        ],
                      )
                    : Text(s.label),
                onTap: () {
                  ref.read(selectedSeasonIdProvider.notifier).select(s.id);
                  Navigator.pop(context);
                },
              ),
            ],
          ],
        ),
        loading: () => CircularProgressIndicator(),
        error: (e, st) => Center(child: Text('Erreur : $e')),
      ),
    );
  }
}
