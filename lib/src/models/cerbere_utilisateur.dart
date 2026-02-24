import 'package:equatable/equatable.dart';

/// Modèle représentant l'association entre un utilisateur et un rôle
class CerbereUtilisateur extends Equatable {
  /// {@macro cerbere_utilisateur}
  const CerbereUtilisateur({
    required this.utilisateurUid,
    required this.roleUid,
    this.isAdmin = false,
  });

  /// Crée un CerbereUtilisateur à partir d'un document Firestore
  factory CerbereUtilisateur.fromFirestore(Map<String, dynamic> json) {
    return CerbereUtilisateur(
      utilisateurUid: json['utilisateurUid']?.toString() ?? '',
      roleUid: json['roleUid']?.toString() ?? '',
      isAdmin: json['isAdmin'] as bool? ?? false,
    );
  }

  /// Identifiant de l'utilisateur Firebase Auth
  final String utilisateurUid;

  /// Identifiant du rôle assigné
  final String roleUid;

  /// Indique si l'utilisateur est un administrateur
  final bool isAdmin;

  /// Convertit le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'utilisateurUid': utilisateurUid,
      'roleUid': roleUid,
      'isAdmin': isAdmin,
    };
  }

  /// Crée une copie du modèle avec des valeurs modifiées
  CerbereUtilisateur copyWith({
    String? utilisateurUid,
    String? roleUid,
    bool? isAdmin,
  }) {
    return CerbereUtilisateur(
      utilisateurUid: utilisateurUid ?? this.utilisateurUid,
      roleUid: roleUid ?? this.roleUid,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object> get props => [
    utilisateurUid,
    roleUid,
    isAdmin,
  ];
}
