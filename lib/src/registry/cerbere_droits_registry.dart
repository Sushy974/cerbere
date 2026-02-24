import '../exceptions/cerbere_exception.dart';
import '../models/cerbere_droit.dart';

/// Registry pour gérer la liste des droits disponibles dans l'application
///
/// Ce registry permet de centraliser la liste des droits et de vérifier
/// la cohérence si plusieurs widgets d'initialisation sont utilisés.
class CerbereDroitsRegistry {
  static List<CerbereDroit>? _droits;
  static Map<String, CerbereDroit>? _droitsByCle;

  /// Enregistre la liste des droits disponibles
  ///
  /// Lance une exception si une liste différente a déjà été enregistrée
  /// ou si des clés sont dupliquées.
  static void register(List<CerbereDroit> droits) {
    // Vérifier les doublons de clés
    final cles = droits.map((d) => d.cle).toList();
    final clesUniques = cles.toSet();
    if (cles.length != clesUniques.length) {
      final doublons = cles
          .where((cle) => cles.where((c) => c == cle).length > 1)
          .toSet();
      throw CerbereException(
        'Des droits avec des clés dupliquées ont été détectés: ${doublons.join(", ")}',
        code: 'DROITS_DUPLIQUES',
      );
    }

    if (_droits != null) {
      // Vérifier si les listes sont identiques (par clé)
      final existingCles = _droits!.map((d) => d.cle).toSet();
      final newCles = droits.map((d) => d.cle).toSet();

      if (existingCles.length != newCles.length ||
          !existingCles.containsAll(newCles) ||
          !newCles.containsAll(existingCles)) {
        throw CerbereException(
          'Les listes de droits sont différentes. '
          'Liste existante: ${existingCles.join(", ")}. '
          'Nouvelle liste: ${newCles.join(", ")}. '
          'Assurez-vous d\'utiliser la même liste dans '
          'CerbereInitWidget et CerbereAdminInitWidget.',
          code: 'DROITS_INCOHERENTS',
        );
      }
    }

    _droits = List.unmodifiable(droits);
    _droitsByCle = {
      for (final droit in droits) droit.cle: droit,
    };
  }

  /// Récupère la liste de tous les droits enregistrés
  ///
  /// Lance une exception si les droits n'ont pas été initialisés.
  static List<CerbereDroit> get all {
    if (_droits == null) {
      throw CerbereException(
        'Les droits n\'ont pas été initialisés. '
        'Utilisez CerbereInitWidget (ou CerbereAdminInitWidget si applicable) '
        'avec la liste des droits.',
        code: 'DROITS_NON_INITIALISES',
      );
    }
    return _droits!;
  }

  /// Récupère un droit par sa clé
  ///
  /// Retourne `null` si le droit n'existe pas.
  static CerbereDroit? getDroitByCle(String cle) {
    if (_droitsByCle == null) return null;
    return _droitsByCle![cle];
  }

  /// Vérifie si un droit existe dans la liste enregistrée
  static bool contains(String cle) {
    if (_droitsByCle == null) return false;
    return _droitsByCle!.containsKey(cle);
  }

  /// Réinitialise le registry (utile pour les tests)
  static void reset() {
    _droits = null;
    _droitsByCle = null;
  }
}
