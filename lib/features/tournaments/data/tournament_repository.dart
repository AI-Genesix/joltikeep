import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models.dart';

class TournamentRepository {
  TournamentRepository(this._db, this._uid);

  final FirebaseFirestore _db;
  final String _uid;

  CollectionReference<Map<String, dynamic>> get _seasons =>
      _db.collection('users').doc(_uid).collection('seasons');

  CollectionReference<Map<String, dynamic>> _tournaments(String seasonId) =>
      _seasons.doc(seasonId).collection('tournaments');

  // Récupérer feed des saisons
  Stream<List<Season>> watchSeasons() {
    return _seasons
        .orderBy('start', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((s) => Season.fromMap(s.id, s.data())).toList(),
        );
  }

  // Récupérer feed des touraments d'une saison
  Stream<List<Tournament>> watchTournaments(String seasonId) {
    return _tournaments(seasonId)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((t) => Tournament.fromMap(t.id, t.data()))
              .toList(),
        );
  }

  // Récupérer infos d'un tournoi
  Stream<Tournament?> watchTournament(String seasonId, String tournamentId) {
    return _tournaments(seasonId).doc(tournamentId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return Tournament.fromMap(snapshot.id, snapshot.data()!);
    });
  }

  Future<void> saveSeason(Season season) {
    return _seasons.doc(season.id).set(season.toMap());
  }

  Future<void> saveTournament(String seasonId, Tournament tournament) {
    return _tournaments(seasonId).doc(tournament.id).set(tournament.toMap());
  }

  Future<void> deleteTournament(String seasonId, String tournamentId) {
    return _tournaments(seasonId).doc(tournamentId).delete();
  }

  String newTournamentId(String seasonId) => _tournaments(seasonId).doc().id;
  String newSeasonId() => _seasons.doc().id;
}
