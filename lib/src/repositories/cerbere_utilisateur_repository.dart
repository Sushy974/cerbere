import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cerbere_utilisateur.dart';
import '../exceptions/cerbere_exception.dart';

/// Interface abstraite pour le repository des utilisateurs
abstract class CerbereUtilisateurRepository {
  /// Récupère toutes les associations utilisateur-rôle
  Future<List<CerbereUtilisateur>> getAllUtilisateurs();

  /// Écoute les changements de la liste des utilisateurs
  Stream<List<CerbereUtilisateur>> listenUtilisateurs();

  /// Récupère l'association pour un utilisateur par son UID
  Future<CerbereUtilisateur?> getUtilisateurByUid(String utilisateurUid);

  /// Assigne un rôle à un utilisateur
  Future<void> assignRoleToUser(String utilisateurUid, String roleUid);

  /// Supprime le rôle d'un utilisateur
  Future<void> removeRoleFromUser(String utilisateurUid);

  /// Indique si l'utilisateur est marqué comme administrateur.
  Future<bool> isAdmin(String utilisateurUid);
}

/// Implémentation Firestore du repository des utilisateurs
class FirestoreCerbereUtilisateurRepository
    implements CerbereUtilisateurRepository {
  /// {@macro firestore_cerbere_utilisateur_repository}
  FirestoreCerbereUtilisateurRepository({
    required FirebaseFirestore firestore,
    FirebaseAuth? firebaseAuth,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  static const String _collection = '_cerbere_utilisateur';

  @override
  Future<List<CerbereUtilisateur>> getAllUtilisateurs() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs
          .map(
            (doc) => CerbereUtilisateur.fromFirestore({
              'utilisateurUid': doc.id,
              ...doc.data(),
            }),
          )
          .toList();
    } catch (e) {
      throw CerbereException(
        'Erreur lors de la récupération des utilisateurs: ${e.toString()}',
      );
    }
  }

  @override
  Stream<List<CerbereUtilisateur>> listenUtilisateurs() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => CerbereUtilisateur.fromFirestore({
              'utilisateurUid': doc.id,
              ...doc.data(),
            }),
          )
          .toList();
    });
  }

  @override
  Future<CerbereUtilisateur?> getUtilisateurByUid(
    String utilisateurUid,
  ) async {
    try {
      final doc = await _firestore
          .collection(_collection)
          .doc(utilisateurUid)
          .get();
      if (!doc.exists) return null;
      return CerbereUtilisateur.fromFirestore({
        'utilisateurUid': doc.id,
        ...doc.data()!,
      });
    } catch (e) {
      throw CerbereException(
        "Erreur lors de la récupération de l'utilisateur: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> assignRoleToUser(
    String utilisateurUid,
    String roleUid,
  ) async {
    try {
      await _firestore.collection(_collection).doc(utilisateurUid).set({
        'utilisateurUid': utilisateurUid,
        'roleUid': roleUid,
      });
    } catch (e) {
      throw CerbereException(
        "Erreur lors de l'assignation du rôle: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> removeRoleFromUser(String utilisateurUid) async {
    try {
      await _firestore.collection(_collection).doc(utilisateurUid).delete();
    } catch (e) {
      throw CerbereException(
        "Erreur lors de la suppression du rôle de l'utilisateur: ${e.toString()}",
      );
    }
  }

  @override
  Future<bool> isAdmin(String utilisateurUid) async {
    return _firestore
        .collection(_collection)
        .doc(utilisateurUid)
        .get()
        .then((value) => value.data()?['isAdmin'] as bool? ?? false);
  }
}
