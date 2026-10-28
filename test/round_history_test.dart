import 'package:flutter_test/flutter_test.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

void main() {
  test('fromCode retrouve la bonne valeur', () {
    for (final r in RoundHistory.values) {
      expect(RoundHistory.fromCode(r.code), r);
    }
  });
  test('Unicité des valeurs', () {
    final codes = RoundHistory.values.map((r) => r.code).toSet();
    expect(codes.length, RoundHistory.values.length);
  });
}
