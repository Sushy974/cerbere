import 'package:equatable/equatable.dart';

/// Modèle représentant un rôle dans Cerbere
class CerbereRole extends Equatable {
  /// {@macro heracles_role}
  const CerbereRole({
    required this.uid,
    required this.nom,
    required this.droits,
  });

  /// Crée un CerbereRole à partir d'un document Firestore
  factory CerbereRole.fromFirestore(Map<String, dynamic> json) {
    return CerbereRole(
      uid: json['uid']?.toString() ?? '',
      nom: json['nom']?.toString() ?? '',
      droits:
          (json['droits'] as List<dynamic>?)
              ?.map((e) => e?.toString() ?? '')
              .where((e) => e.isNotEmpty)
              .toList() ??
          [],
    );
  }

  /// Identifiant unique du rôle
  final String uid;

  /// Nom du rôle
  final String nom;

  /// Liste des clés de droits associés au rôle
  final List<String> droits;

  /// Convertit le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'nom': nom,
      'droits': droits,
    };
  }

  /// Crée une copie du modèle avec des valeurs modifiées
  CerbereRole copyWith({
    String? uid,
    String? nom,
    List<String>? droits,
  }) {
    return CerbereRole(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      droits: droits ?? this.droits,
    );
  }

  @override
  List<Object> get props => [
    uid,
    nom,
    droits,
  ];
}
