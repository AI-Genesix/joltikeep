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

  Stream<List<Season>> watchSeasons() {
    return _seasons
        .orderBy('start', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((s) => Season.fromMap(s.id, s.data())).toList(),
        );
  }
}
