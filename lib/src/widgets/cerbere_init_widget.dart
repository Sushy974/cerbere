import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/cerbere_role_repository.dart';
import '../repositories/cerbere_utilisateur_repository.dart';
import '../services/cerbere_service.dart';
import '../registry/cerbere_droits_registry.dart';
import '../models/cerbere_droit.dart';

/// Widget d'initialisation Cerbère
///
/// À placer au plus haut niveau de votre app, idéalement dans main()
///
/// Exemple:
/// ```dart
/// void main() {
///   runApp(
///     CerbereInitWidget(
///       firebaseAuth: FirebaseAuth.instance,
///       firestore: FirebaseFirestore.instance,
///       droits: [
///         CerbereDroit(
///           cle: 'can_edit_users',
///           nom: 'Éditer les utilisateurs',
///           description: 'Permet d\'éditer les utilisateurs',
///         ),
///         CerbereDroit(
///           cle: 'can_delete_users',
///           nom: 'Supprimer les utilisateurs',
///           description: 'Permet de supprimer les utilisateurs',
///         ),
///       ],
///       child: MyApp(),
///     ),
///   );
/// }
/// ```
class CerbereInitWidget extends StatelessWidget {
  /// {@macro cerbere_init_widget}
  const CerbereInitWidget({
    required this.child,
    required this.firebaseAuth,
    required this.firestore,
    required this.droits,
    super.key,
  });

  /// Widget enfant (généralement votre App)
  final Widget child;

  /// Instance Firebase Auth
  final FirebaseAuth firebaseAuth;

  /// Instance Firestore
  final FirebaseFirestore firestore;

  /// Liste des droits disponibles dans l'application
  final List<CerbereDroit> droits;

  @override
  Widget build(BuildContext context) {
    // Enregistrer la liste des droits dans le registry
    CerbereDroitsRegistry.register(droits);

    // Création des repositories
    final roleRepository = FirestoreCerbereRoleRepository(
      firestore: firestore,
    );

    final utilisateurRepository = FirestoreCerbereUtilisateurRepository(
      firestore: firestore,
      firebaseAuth: firebaseAuth,
    );

    // Création du service
    final service = CerbereService(
      firebaseAuth: firebaseAuth,
      roleRepository: roleRepository,
      utilisateurRepository: utilisateurRepository,
    );

    // Enveloppe l'app avec les providers nécessaires
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CerbereRoleRepository>.value(
          value: roleRepository,
        ),
        RepositoryProvider<CerbereUtilisateurRepository>.value(
          value: utilisateurRepository,
        ),
        RepositoryProvider<CerbereService>.value(
          value: service,
        ),
      ],
      child: child,
    );
  }
}
