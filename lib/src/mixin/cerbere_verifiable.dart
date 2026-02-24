import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cerbere/cerbere.dart';

/// Mixin pour ajouter la vérification de permissions à n'importe quelle classe
mixin CerbereVerifiable {
  /// Clé de permission requise pour accéder à cet élément
  /// Retourne null si aucune permission n'est requise
  String? get permissionCle;

  /// Vérifie si l'utilisateur a la permission nécessaire
  /// Nécessite un BuildContext pour accéder au CerbereService
  Future<bool> verifiePermission(BuildContext context) async {
    if (permissionCle == null) return true;

    final service = context.read<CerbereService>();
    return service.cerbereVerifie(permissionCle!);
  }
}
