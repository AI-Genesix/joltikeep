import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';
import 'package:joltikeep/features/tournaments/presentation/formatters.dart';

class SeasonFormScreen extends ConsumerStatefulWidget {
  const SeasonFormScreen({super.key});

  @override
  ConsumerState<SeasonFormScreen> createState() => _SeasonFormScreenState();
}

class _SeasonFormScreenState extends ConsumerState<SeasonFormScreen> {
  final _nameController = TextEditingController();
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
    final datesError = seasonDatesErrror(_start, _end);

    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle saison')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom de la saison'),
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
            datesError != null
                ? Text(
                    datesError,
                    style: TextStyle(fontSize: 12, color: AppColors.loss),
                  )
                : SizedBox(),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: datesError == null ? _submit : null,
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {}
}
