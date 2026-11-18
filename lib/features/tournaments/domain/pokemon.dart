import 'dart:convert';

class Pokemon {
  const Pokemon({required this.id, required this.name});

  final int id;
  final String name;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(id: json['id'] as int, name: json['name'] as String);
  }
}

List<Pokemon> parsePokedex(String raw) {
  final decoded = jsonDecode(raw) as List;
  return [
    for (final item in decoded) Pokemon.fromJson(item as Map<String, dynamic>),
  ];
}

const maxDeckPokemon = 2;

const _accents = {
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'à': 'a', 'â': 'a',
  'î': 'i', 'ï': 'i',
  'ô': 'o',
  'ù': 'u', 'û': 'u',
  'ç': 'c',
  'œ': 'oe',
};

String normalizeForSearch(String s) {
  var result = s.toLowerCase();
  for (final a in _accents.entries) {
    result = result.replaceAll(a.key, a.value);
  }
  return result;
}

List<Pokemon> filterPokedex(List<Pokemon> all, String query) {
  final q = normalizeForSearch(query.trim());
  if (q.isEmpty) return all;
  
  final list = <Pokemon>[];
  for (final a in all) {
    if (a.name.contains(q)) list.add(a);
  }
  return list;
}

List<Pokemon> toggleSelection(List<Pokemon> selected, Pokemon p) {
  final alreadySelected = selected.any((s) => s.id == p.id);
  if (alreadySelected) {
    return selected.where((s) => s.id != p.id).toList();
  }
  if (selected.length >= maxDeckPokemon) {
    return selected;
  }
  return [...selected, p];
}