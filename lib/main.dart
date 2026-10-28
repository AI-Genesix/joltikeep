import 'package:firebase_core/firebase_core.dart'; // Point d'entrée Firebase
import 'package:flutter/material.dart'; // Widgets de base Flutter
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Gestion d'état
import 'package:firebase_auth/firebase_auth.dart'; // Authentification
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart'; // Identifiants projet

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Liaison Flutter / Android
  await Firebase.initializeApp(
    // Connexion au projet Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Connexion anonyme
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }
  // debugPrint('uid = ${FirebaseAuth.instance.currentUser?.uid}');
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // Test écriture et lecture
  /*
  try {
    final ref = FirebaseFirestore.instance.collection('users')
    .doc('fakeuser').collection('seasons').doc('test');
    await ref.set({'label': 'Saison test'});

    final snap = await ref.get();
    debugPrint('Résultat get : ${snap.data()}');
  }
  catch (e) {
    debugPrint(e.toString());
  }
  */

  runApp(const ProviderScope(child: JoltikeepApp()));
}

// Dummy screen
class JoltikeepApp extends StatelessWidget {
  // Futur : gestion thème / navigation
  const JoltikeepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Joltikeep'))),
    );
  }
}
