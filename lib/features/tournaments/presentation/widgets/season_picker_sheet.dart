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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: seasons.when(
          data: (list) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choisir une saison',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final s in list)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(s.label),
                        subtitle: Text(
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                          '${s.start.day.toString().padLeft(2, '0')}/${s.start.month.toString().padLeft(2, '0')}/${s.start.year} – ${s.end.day.toString().padLeft(2, '0')}/${s.end.month.toString().padLeft(2, '0')}/${s.end.year}',
                        ),
                        selected: s.id == displayedId,
                        trailing: s.id == displayedId
                            ? const Icon(Icons.check)
                            : null,
                        onTap: () {
                          ref
                              .read(selectedSeasonIdProvider.notifier)
                              .select(s.id);
                          Navigator.pop(context);
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, st) => Center(child: Text('Erreur : $e')),
        ),
      ),
    );
  }
}
