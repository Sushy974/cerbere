import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/cerbere_role_repository.dart';
import '../repositories/cerbere_utilisateur_repository.dart';
import '../exceptions/cerbere_exception.dart';

/// Service principal pour la vérification des permissions Cerbère
class CerbereService {
  /// {@macro cerbere_service}
  CerbereService({
    required this.firebaseAuth,
    required this.roleRepository,
    required this.utilisateurRepository,
  });

  /// Instance Firebase Auth
  final FirebaseAuth firebaseAuth;

  /// Repository des rôles
  final CerbereRoleRepository roleRepository;

  /// Repository des utilisateurs
  final CerbereUtilisateurRepository utilisateurRepository;

  /// Vérifie si l'utilisateur connecté a la clé de droit
  ///
  /// Retourne `true` si l'utilisateur a le droit, `false` sinon.
  /// Lance une exception si aucun utilisateur n'est connecté.
  Future<bool> cerbereVerifie(String cle) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw CerbereException('Aucun utilisateur connecté');
    }

    try {
      final cerbereUtilisateur = await utilisateurRepository
          .getUtilisateurByUid(user.uid);
      if (cerbereUtilisateur == null) {
        return false;
      }
      if (cerbereUtilisateur.isAdmin) {
        return true;
      }

      final role = await roleRepository.getRoleByUid(
        cerbereUtilisateur.roleUid,
      );
      if (role == null) {
        return false;
      }

      return role.droits.contains(cle);
    } catch (e) {
      if (e is CerbereException) rethrow;
      throw CerbereException(
        'Erreur lors de la vérification du droit: ${e.toString()}',
      );
    }
  }

  /// Stream qui vérifie en temps réel si l'utilisateur a la clé de droit
  ///
  /// Retourne un stream de booléens qui se met à jour automatiquement
  /// lorsque le rôle de l'utilisateur ou les droits du rôle changent.
  Stream<bool> cerbereStreamVerifie(String cle) {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return Stream.value(false);
    }

    // Écoute les changements des utilisateurs
    return utilisateurRepository.listenUtilisateurs().asyncExpand(
      (utilisateurs) {
        // Trouve l'utilisateur
        try {
          final cerbereUtilisateur = utilisateurs.firstWhere(
            (u) => u.utilisateurUid == user.uid,
          );
          if (cerbereUtilisateur.isAdmin) {
            return Stream.value(true);
          }
          // Si roleUid est vide, l'utilisateur n'a pas de rôle
          if (cerbereUtilisateur.roleUid.isEmpty) {
            return Stream.value(false);
          }
          // Écoute les changements des rôles
          return roleRepository.listenRoles().map((roles) {
            try {
              // Trouve le rôle
              final role = roles.firstWhere(
                (r) => r.uid == cerbereUtilisateur.roleUid,
              );

              // Vérifie si la clé existe dans les droits
              return role.droits.contains(cle);
            } catch (e) {
              return false;
            }
          });
        } catch (e) {
          return Stream.value(false);
        }
      },
    );
  }
}
