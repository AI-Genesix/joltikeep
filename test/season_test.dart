import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

final season = Season(
  id: 'a',
  label: "2027 Season",
  start: DateTime.parse("2026-09-01"),
  end: DateTime.parse("2027-05-31"),
);

void main() {
  test('Season toMap', () {
    expect(season.toMap(), {
      'label': "2027 Season",
      'start': Timestamp.fromDate(DateTime.parse('2026-09-01')),
      'end': Timestamp.fromDate(DateTime.parse('2027-05-31')),
    });
  });
  test('Season fromMap', () {
    final map = <String, dynamic>{
      'label': "2027 Season",
      'start': Timestamp.fromDate(DateTime.parse('2026-09-01')),
      'end': Timestamp.fromDate(DateTime.parse('2027-05-31')),
    };
    final s = Season.fromMap("s1", map);
    expect(s.label, "2027 Season");
    expect(s.start, DateTime.parse("2026-09-01"));
    expect(s.end, DateTime.parse("2027-05-31"));
  });
  test('Season date in range', () {
    expect(season.isActiveAt(DateTime.parse('2026-12-15')), true);
    expect(season.isActiveAt(DateTime.parse("2024-05-31")), false);
    expect(season.isActiveAt(DateTime.parse("2028-05-31")), false);
  });
}

