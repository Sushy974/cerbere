import 'package:equatable/equatable.dart';

/// Modèle représentant un droit dans Cerbere
class CerbereDroit extends Equatable {
  /// Crée un droit avec [cle], [nom], [description] et optionnellement [cleDroitLie].
  const CerbereDroit({
    required this.cle,
    required this.nom,
    required this.description,
    this.cleDroitLie,
  });

  /// Clé unique du droit (identifiant)
  final String cle;

  /// Nom lisible du droit
  final String nom;

  /// Description du droit
  final String description;

  /// Clé d'un droit lié (optionnel)
  final String? cleDroitLie;

  /// Crée une copie du modèle avec des valeurs modifiées
  CerbereDroit copyWith({
    String? cle,
    String? nom,
    String? description,
    String? cleDroitLie,
  }) {
    return CerbereDroit(
      cle: cle ?? this.cle,
      nom: nom ?? this.nom,
      description: description ?? this.description,
      cleDroitLie: cleDroitLie ?? this.cleDroitLie,
    );
  }

  @override
  List<Object?> get props => [cle, nom, description, cleDroitLie];
}
