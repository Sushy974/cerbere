import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/cerbere_service.dart';

/// Widget qui affiche conditionnellement un widget selon les permissions
///
/// Vérifie si l'utilisateur connecté a la clé de droit spécifiée.
/// Affiche le widget enfant si autorisé, sinon affiche deniedWidget ou rien.
class CerbereWidgetVerifie extends StatelessWidget {
  /// {@macro cerbere_widget_verifie}
  const CerbereWidgetVerifie({
    required this.cle,
    required this.child,
    this.loadingWidget,
    this.deniedWidget,
    super.key,
  });

  /// Clé de droit à vérifier
  final String cle;

  /// Widget à afficher si l'utilisateur a le droit
  final Widget child;

  /// Widget à afficher pendant le chargement (par défaut: CircularProgressIndicator)
  final Widget? loadingWidget;

  /// Widget à afficher si l'utilisateur n'a pas le droit (par défaut: SizedBox.shrink())
  final Widget? deniedWidget;

  @override
  Widget build(BuildContext context) {
    // Récupère le service depuis le Provider (fourni par CerbereInitWidget)
    try {
      final cerbereService = context.read<CerbereService>();

      return StreamBuilder<bool>(
        stream: cerbereService.cerbereStreamVerifie(cle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingWidget ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }

          if (snapshot.hasError) {
            // En cas d'erreur, on affiche l'erreur pour le debug
            // En production, on pourrait vouloir cacher le widget
            return Center(
              child: Text(
                'Erreur: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Si pas de données ou false, on cache le widget
          if (!snapshot.hasData || snapshot.data == false) {
            return deniedWidget ?? const SizedBox.shrink();
          }

          return child;
        },
      );
    } catch (e) {
      // Si le service n'est pas disponible, on affiche le widget denied
      return deniedWidget ?? const SizedBox.shrink();
    }
  }
}
