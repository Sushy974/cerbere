import 'package:flutter/widgets.dart';
import 'package:cerbere/cerbere.dart';

/// Extension sur [Widget] pour appliquer une vérification de droits
/// Cerbère sans avoir à envelopper manuellement le widget dans un
/// [CerbereWidgetVerifie].
extension CerbereWidgetExtension on Widget {
  /// Rend ce widget conditionnel à la [cle] de droit spécifiée.
  ///
  /// Si l'utilisateur possède le droit, le widget est affiché tel quel.
  /// Sinon, [deniedWidget] est affiché (ou un [SizedBox.shrink] par défaut).
  /// Pendant la vérification, [loadingWidget] est affiché.
  Widget cerbereVerifie(
    String cle, {
    Widget? deniedWidget,
    Widget? loadingWidget,
  }) {
    return CerbereWidgetVerifie(
      cle: cle,
      deniedWidget: deniedWidget,
      loadingWidget: loadingWidget,
      child: this,
    );
  }
}
