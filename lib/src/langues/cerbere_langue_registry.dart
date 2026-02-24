import '../exceptions/cerbere_exception.dart';
import 'cerbere_langue.dart';

/// Registry pour gérer la langue active dans l'application
///
/// Ce registry permet de centraliser la langue et de la rendre accessible
/// dans tout le package.
class CerbereLangueRegistry {
  static CerbereLangue? _langue;

  /// Enregistre la langue active
  static void register(CerbereLangue langue) {
    _langue = langue;
  }

  /// Récupère la langue active
  ///
  /// Retourne [CerbereLangue.fr] par défaut si la langue n'a pas été initialisée.
  /// Lance une exception si vous souhaitez forcer l'initialisation.
  static CerbereLangue get current {
    return _langue ?? CerbereLangue.fr;
  }

  /// Vérifie si la langue a été initialisée
  static bool get isInitialized => _langue != null;

  /// Récupère la langue active (lance une exception si non initialisée)
  ///
  /// Utilisez cette méthode si vous voulez forcer l'initialisation de la langue.
  static CerbereLangue get currentOrThrow {
    if (_langue == null) {
      throw CerbereException(
        'La langue n\'a pas été initialisée. '
        'Utilisez CerbereInitWidget ou CerbereAdminInitWidget '
        'avec le paramètre langue.',
        code: 'LANGUE_NON_INITIALISEE',
      );
    }
    return _langue!;
  }

  /// Réinitialise le registry (utile pour les tests)
  static void reset() {
    _langue = null;
  }
}
