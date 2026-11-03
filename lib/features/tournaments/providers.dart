import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joltikeep/features/tournaments/data/tournament_repository.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

final userIdProvider = Provider<String>((ref) {
  return FirebaseAuth.instance.currentUser!.uid;
});

final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  final uid = ref.watch(userIdProvider);
  return TournamentRepository(FirebaseFirestore.instance, uid);
});

final seasonsProvider = StreamProvider<List<Season>>((ref) {
  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.watchSeasons();
});

final tournamentsProvider = StreamProvider.family<List<Tournament>, String>((
  ref,
  seasonId,
) {
  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.watchTournaments(seasonId);
});
