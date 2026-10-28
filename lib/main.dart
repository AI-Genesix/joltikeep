import 'package:firebase_core/firebase_core.dart'; // Point d'entrée Firebase
import 'package:flutter/material.dart'; // Widgets de base Flutter
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Gestion d'état

import 'firebase_options.dart'; // Identifiants projet

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Liaison Flutter / Android
  await Firebase.initializeApp( // Connexion au projet Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: JoltikeepApp()));
}

// Dummy screen
class JoltikeepApp extends StatelessWidget { // Futur : gestion thème / navigation
  const JoltikeepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Joltikeep')),
      )
    );
  }
}