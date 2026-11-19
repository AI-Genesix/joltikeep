import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';
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

  void _confirm() {
    final deck = Deck(
      name: deckName(_selected.map((p) => p.name).toList()),
      pokemonIds: _selected.map((p) => p.id).toList(),
    );
    Navigator.pop(context, deck);
  }

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
        Wrap(
          spacing: 8,
          children: [
            for (final p in _selected)
              InputChip(
                label: Text(p.name),
                onDeleted: () =>
                    setState(() => _selected = toggleSelection(_selected, p)),
              ),
          ],
        ),
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
              final position = _selected.indexWhere((s) => s.id == p.id);
              return ListTile(
                title: Text(p.name),
                selected: position != -1,
                trailing: position == -1 ? null : Text('${position + 1}'),
                onTap: () {
                  if (position == -1 && _selected.length >= maxDeckPokemon) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('2 Pokémon maximum')),
                    );
                    return;
                  }
                  setState(() => _selected = toggleSelection(_selected, p));
                },
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _selected.isEmpty ? null : _confirm,
                child: const Text('Valider'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
