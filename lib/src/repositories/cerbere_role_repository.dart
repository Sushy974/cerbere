import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cerbere_role.dart';
import '../exceptions/cerbere_exception.dart';

/// Interface abstraite pour le repository des rôles
abstract class CerbereRoleRepository {
  /// Récupère tous les rôles
  Future<List<CerbereRole>> getAllRoles();

  /// Écoute les changements de la liste des rôles
  Stream<List<CerbereRole>> listenRoles();

  /// Récupère un rôle par son UID
  Future<CerbereRole?> getRoleByUid(String uid);

  /// Crée un nouveau rôle
  Future<String> createRole(CerbereRole role);

  /// Met à jour un rôle existant
  Future<void> updateRole(CerbereRole role);

  /// Supprime un rôle
  Future<void> deleteRole(String uid);
}

/// Implémentation Firestore du repository des rôles
class FirestoreCerbereRoleRepository implements CerbereRoleRepository {
  /// {@macro firestore_cerbere_role_repository}
  FirestoreCerbereRoleRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  static const String _collection = '_cerbere_roles';

  @override
  Future<List<CerbereRole>> getAllRoles() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs
          .map(
            (doc) => CerbereRole.fromFirestore({
              'uid': doc.id,
              ...doc.data(),
            }),
          )
          .toList();
    } catch (e) {
      throw CerbereException(
        'Erreur lors de la récupération des rôles: ${e.toString()}',
      );
    }
  }

  @override
  Stream<List<CerbereRole>> listenRoles() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => CerbereRole.fromFirestore({
              'uid': doc.id,
              ...doc.data(),
            }),
          )
          .toList();
    });
  }

  @override
  Future<CerbereRole?> getRoleByUid(String uid) async {
    try {
      // Vérifie que l'uid n'est pas vide avant d'appeler doc()
      if (uid.isEmpty) {
        return null;
      }
      final doc = await _firestore.collection(_collection).doc(uid).get();
      if (!doc.exists) return null;
      return CerbereRole.fromFirestore({
        'uid': doc.id,
        ...doc.data()!,
      });
    } catch (e) {
      throw CerbereException(
        'Erreur lors de la récupération du rôle: ${e.toString()}',
      );
    }
  }

  @override
  Future<String> createRole(CerbereRole role) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(role.uid)
          .set(role.toFirestore());
      return role.uid;
    } catch (e) {
      throw CerbereException(
        'Erreur lors de la création du rôle: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> updateRole(CerbereRole role) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(role.uid)
          .set(role.toFirestore());
    } catch (e) {
      throw CerbereException(
        'Erreur lors de la mise à jour du rôle: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteRole(String uid) async {
    try {
      await _firestore.collection(_collection).doc(uid).delete();
    } catch (e) {
      throw CerbereException(
        'Erreur lors de la suppression du rôle: ${e.toString()}',
      );
    }
  }
}
