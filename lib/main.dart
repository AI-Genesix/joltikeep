import 'package:firebase_core/firebase_core.dart'; // Point d'entrée Firebase
import 'package:flutter/material.dart'; // Widgets de base Flutter
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Gestion d'état
import 'package:firebase_auth/firebase_auth.dart'; // Authentification
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';
import 'package:joltikeep/features/tournaments/presentation/widgets/season_header.dart';
import 'package:joltikeep/features/tournaments/presentation/widgets/season_picker_sheet.dart';
import 'package:joltikeep/features/tournaments/presentation/widgets/tournament_card.dart';
import 'package:joltikeep/features/tournaments/presentation/widgets/tournament_deletion.dart';
import 'package:joltikeep/features/tournaments/providers.dart';

import 'firebase_options.dart'; // Identifiants projet

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Liaison Flutter / Android
  await Firebase.initializeApp(
    // Connexion au projet Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Connexion anonyme
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }
  // debugPrint('uid = ${FirebaseAuth.instance.currentUser?.uid}');

  // Test écriture et lecture
  /*
  try {
    final ref = FirebaseFirestore.instance.collection('users')
    .doc('fakeuser').collection('seasons').doc('test');
    await ref.set({'label': 'Saison test'});

    final snap = await ref.get();
    debugPrint('Résultat get : ${snap.data()}');
  }
  catch (e) {
    debugPrint(e.toString());
  }
  */

  runApp(const ProviderScope(child: JoltikeepApp()));
}

// Dummy screen
class JoltikeepApp extends StatelessWidget {
  // Futur : gestion thème / navigation
  const JoltikeepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: buildTheme(), home: HomeScreen());
  }
}

//HomeScreen
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(displayedSeasonProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final repo = ref.read(tournamentRepositoryProvider);
          repo.saveSeason(
            Season(
              id: repo.newSeasonId(),
              label: 'Saison 2027',
              start: DateTime(2026, 9, 1),
              end: DateTime(2027, 8, 31),
            ),
          );
        },
      ),
      body: SafeArea(
        child: season.when(
          data: (s) => s == null
              ? const Center(child: Text('Aucune saison'))
              : _SeasonView(season: s),
          error: (e, st) => Center(child: Text('Erreur : $e')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _SeasonView extends ConsumerWidget {
  const _SeasonView({required this.season});

  final Season season;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournaments = ref.watch(tournamentsProvider(season.id));
    return Column(
      children: [
        TextButton(
          onPressed: () {
            final repo = ref.read(tournamentRepositoryProvider);
            repo.saveTournament(
              season.id,
              Tournament(
                id: repo.newTournamentId(season.id),
                name: "Tournoi test",
                type: TournamentType.challenge,
                date: DateTime.now(),
                deck: const Deck(name: "Hide 'n Sneak", pokemonIds: [781, 384]),
                result: TournamentResult.top8,
                cps: 280,
              ),
            );
          },
          child: const Text('Ajouter un tournoi test'),
        ),
        Expanded(
          child: tournaments.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SeasonHeader(
                  label: season.label,
                  isCurrent: season.isActiveAt(DateTime.now()),
                  totalCps: totalCps(list),
                  tournamentCount: list.length,
                  record: seasonRecord(list),
                  onSeasonTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const SeasonPickerSheet(),
                  ),
                ),
                const SizedBox(height: 24),
                for (final t in list) ...[
                  TournamentCard(
                    tournament: t,
                    onLongPress: () async {
                      final ok = await confirmDeleteTournament(context, t);
                      if (!ok || !context.mounted) return;
                      ref
                          .read(tournamentRepositoryProvider)
                          .deleteTournament(season.id, t.id);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Erreur : $e')),
          ),
        ),
      ],
    );
  }
}
