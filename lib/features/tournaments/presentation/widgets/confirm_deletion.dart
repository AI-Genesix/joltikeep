import 'package:flutter/material.dart';
import 'package:joltikeep/app/theme.dart';

Future<bool> confirmDelete(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
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
