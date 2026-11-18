import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joltikeep/features/tournaments/domain/pokemon.dart';
import 'package:joltikeep/features/tournaments/providers.dart';

class DeckPickerScreen extends ConsumerStatefulWidget {
  const DeckPickerScreen({super.key});

  @override
  ConsumerState<DeckPickerScreen> createState() => _DeckPickerScreenState();
}

class _DeckPickerScreenState extends ConsumerState<DeckPickerScreen> {
  List<Pokemon> _selected = [];
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final pokedex = ref.watch(pokedexProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Choisir un deck')),
      body: pokedex.when(
        data: (all) => _buildContent(all),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur : $e')),
      ),
    );
  }

  Widget _buildContent(List<Pokemon> all) {
    final shown = filterPokedex(all, _query);
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Rechercher un Pokémon',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: shown.length,
            itemBuilder: (context, index) {
              final p = shown[index];
              return ListTile(title: Text(p.name), onTap: () {});
            },
          ),
        ),
      ],
    );
  }
}
