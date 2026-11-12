import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';
import 'package:joltikeep/features/tournaments/presentation/formatters.dart';
import 'package:joltikeep/features/tournaments/providers.dart';

class SeasonFormScreen extends ConsumerStatefulWidget {
  const SeasonFormScreen({super.key});

  @override
  ConsumerState<SeasonFormScreen> createState() => _SeasonFormScreenState();
}

class _SeasonFormScreenState extends ConsumerState<SeasonFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _saving = false;
  late DateTime _start;
  late DateTime _end;

  Future<DateTime?> _pickDate(DateTime initial) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  @override
  void initState() {
    super.initState();
    _start = defaultSeasonStart(DateTime.now());
    _end = DateTime(_start.year + 1, 8, 31);
    _nameController.text = "Saison ${_end.year}";
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datesError = seasonDatesError(_start, _end);

    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle saison')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) => (value ?? '').trim().isEmpty
                    ? "Le nom ne peut pas être vide"
                    : null,
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la saison',
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Début'),
                subtitle: Text(formatDate(_start)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await _pickDate(_start);
                  if (picked == null || !mounted) return;
                  setState(() {
                    _start = picked;
                  });
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Fin'),
                subtitle: Text(formatDate(_end)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await _pickDate(_end);
                  if (picked == null || !mounted) return;
                  setState(() {
                    _end = picked;
                  });
                },
              ),
              if (datesError != null)
                Text(
                  datesError,
                  style: TextStyle(fontSize: 12, color: AppColors.loss),
                ),

              const SizedBox(height: 24),
              FilledButton(
                onPressed: datesError == null ? _submit : null,
                child: const Text('Créer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_saving) return;
    _saving = true;
    if (!_formKey.currentState!.validate()) return;
    final repository = ref.read(tournamentRepositoryProvider);
    final id = repository.newSeasonId();
    final season = Season(
      id: id,
      label: _nameController.text.trim(),
      start: _start,
      end: _end,
    );
    repository.saveSeason(season);
    ref.read(selectedSeasonIdProvider.notifier).select(id);
    Navigator.pop(context);
  }
}
