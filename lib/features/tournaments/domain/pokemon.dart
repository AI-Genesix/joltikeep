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
