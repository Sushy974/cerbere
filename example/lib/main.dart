import 'package:cerbere/cerbere.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CerbereExampleApp());
}

/// Application exemple utilisant le package Cerbère.
///
/// Pour un usage réel, initialisez Firebase puis enveloppez votre app
/// avec [CerbereInitWidget] (voir le README du package).
class CerbereExampleApp extends StatelessWidget {
  const CerbereExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cerbère Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemple de liste de droits telle que passée à CerbereInitWidget
    final droits = [
      const CerbereDroit(
        cle: 'can_edit',
        nom: 'Éditer',
        description: 'Droit d\'édition',
      ),
      const CerbereDroit(
        cle: 'can_view',
        nom: 'Voir',
        description: 'Droit de consultation',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerbère Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Ce projet montre comment utiliser le package cerbere. '
            'En production, enveloppez votre app avec CerbereInitWidget '
            'après avoir initialisé Firebase.',
          ),
          const SizedBox(height: 24),
          Text(
            'Droits définis (${droits.length}) :',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ...droits.map(
            (d) => ListTile(
              title: Text(d.nom),
              subtitle: Text(d.description),
              trailing: Text(d.cle, style: const TextStyle(fontFamily: 'monospace')),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Utilisez CerbereWidgetVerifie(cle: "can_edit", child: ...) '
            'pour afficher un widget selon les permissions.',
          ),
        ],
      ),
    );
  }
}
