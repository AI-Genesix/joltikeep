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
  test('Season isActiveAt', () {
    expect(season.isActiveAt(DateTime.parse('2026-12-15')), true);
    expect(season.isActiveAt(DateTime.parse("2024-05-31")), false);
    expect(season.isActiveAt(DateTime.parse("2028-05-31")), false);
    expect(season.isActiveAt(DateTime.parse('2026-09-01')), true);
    expect(season.isActiveAt(DateTime(2027, 5, 31, 18)), true);
    expect(season.isActiveAt(DateTime.parse('2027-06-01')), false);
    expect(season.isActiveAt(DateTime.parse('2026-08-31')), false);
  });
  test('Test pickSeason', () {
    final seasons = [
      Season(
        id: "s4",
        label: "Season 4",
        start: DateTime(2026, 9, 1),
        end: DateTime(2027, 5, 31),
      ),
      Season(
        id: "s3",
        label: "Season 3",
        start: DateTime(2025, 9, 1),
        end: DateTime(2026, 5, 31),
      ),
      Season(
        id: "s2",
        label: "Season 2",
        start: DateTime(2024, 9, 1),
        end: DateTime(2025, 5, 31),
      ),
      Season(
        id: "s1",
        label: "Season 1",
        start: DateTime(2023, 9, 1),
        end: DateTime(2024, 5, 31),
      ),
    ];
    final seasonEmpty = <Season>[];
    expect(pickSeason(seasons, "s2", DateTime(2026, 11, 3))?.label, "Season 2");
    expect(pickSeason(seasons, "s5", DateTime(2025, 11, 3))?.label, "Season 3");
    expect(pickSeason(seasons, "s5", DateTime(2027, 11, 3))?.label, "Season 4");
    expect(pickSeason(seasons, null, DateTime(2027, 11, 3))?.label, "Season 4");
    expect(pickSeason(seasonEmpty, "s5", DateTime(2026, 11, 3)), isNull);
  });
  test('Dates par défaut', () {
    expect(defaultSeasonStart(DateTime(2026, 8, 31)), DateTime(2025, 9, 1));
    expect(defaultSeasonStart(DateTime(2026, 9, 1)), DateTime(2026, 9, 1));
  });
}
