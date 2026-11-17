import 'dart:convert';
import 'dart:io';

List<Map<String, String>> readCSV(String path) {
  final lines = File(path).readAsLinesSync();
  final header = lines.first.split(',');
  return [
    for (final line in lines.skip(1))
      if (line.trim().isNotEmpty) Map.fromIterables(header, line.split(',')),
  ];
}

String humanize(String identifier) => identifier
    .split('-')
    .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
    .join(' ');

void main() {
  final languages = readCSV('tools/data/languages.csv');
  final frId = languages.firstWhere((r) => r['identifier'] == 'fr')['id']!;
  print('Identifiant du français : $frId');

  final speciesNames = {
    for (final r in readCSV('tools/data/pokemon_species_names.csv'))
      if (r['local_language_id'] == frId)
        int.parse(r['pokemon_species_id']!): r['name']!,
  };

  final formIdByPokemon = {
    for (final r in readCSV('tools/data/pokemon_forms.csv'))
      if (r['is_default'] == '1')
        int.parse(r['pokemon_id']!): int.parse(r['id']!),
  };

  final fullNames = <int, String>{};
  final formLabels = <int, String>{};

  for (final r in readCSV('tools/data/pokemon_form_names.csv')) {
    if (r['local_language_id'] != frId) continue;
    final formId = int.parse(r['pokemon_form_id']!);
    final full = r['pokemon_name']!;
    final label = r['form_name']!;
    if (full.isNotEmpty) fullNames[formId] = full;
    if (label.isNotEmpty) formLabels[formId] = label;
  }

  final entries = <Map<String, Object>>[];
  final fallbacks = <String>[];

  for (final p in readCSV('tools/data/pokemon.csv')) {
    final id = int.parse(p['id']!);
    final speciesId = int.parse(p['species_id']!);

    if (p['is_default'] == '1') {
      final name = speciesNames[speciesId];
      if (name == null) {
        fallbacks.add(p['identifier']!);
        continue;
      }
      entries.add({'id': id, 'name': name});
    } else {
      final formId = formIdByPokemon[id];
      final species = speciesNames[speciesId];
      final full = formId == null ? null : fullNames[formId];
      final label = formId == null ? null : formLabels[formId];

      String name;
      if (full != null) {
        name = full;
      } else if (label != null && species != null) {
        name = '$species ($label)';
      } else {
        name = humanize(p['identifier']!);
        fallbacks.add(p['identifier']!);
      }
      entries.add({'id': id, 'name': name});
    }
  }

  print(speciesNames[25]);
  print(speciesNames[6]);
  print('${entries.length} entrées');
  print('Sans nom français : $fallbacks');

  const encoder = JsonEncoder.withIndent('  ');
  File('assets/data/pokedex.json')
    ..createSync(recursive: true)
    ..writeAsStringSync(encoder.convert(entries));
  print('Fichier écrit : ${entries.length} entrées');
}
