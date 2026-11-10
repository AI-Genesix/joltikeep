import 'package:flutter/material.dart';
import 'package:joltikeep/app/theme.dart';
import 'package:joltikeep/features/tournaments/domain/models.dart';

Future<bool> confirmDeleteTournament(BuildContext context, Tournament t) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Supprimer ce tournoi ?'),
      content: Text(
        '« ${t.name} » sera supprimé définitivement, avec ses rondes.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Annuler'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.loss),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Supprimer'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
