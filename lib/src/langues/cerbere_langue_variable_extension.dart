import 'package:cerbere/src/langues/get_localisation.dart';
import 'package:cerbere/src/langues/cerbere_langue_registry.dart';
import 'package:cerbere/src/langues/cerbere_langue_variable.dart';

/// Extension sur [CerbereLangueVariable] pour faciliter l'accès aux traductions
extension CerbereLangueVariableExtension on CerbereLangueVariable {
  /// Retourne la traduction de la variable selon la langue active
  ///
  /// Utilise la langue enregistrée dans [CerbereLangueRegistry].
  /// Si aucune langue n'est enregistrée, utilise [CerbereLangue.fr] par défaut.
  String get traduction {
    final langue = CerbereLangueRegistry.current;
    return GetLocalisation.getLocalisation(langue, this);
  }
}
