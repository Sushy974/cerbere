/// Exception personnalisée pour le package Cerbère
class CerbereException implements Exception {
  /// Message d'erreur descriptif
  final String message;

  /// Code d'erreur optionnel
  final String? code;

  /// Crée une exception avec [message] et optionnellement un [code] pour le diagnostic.
  CerbereException(this.message, {this.code});

  @override
  String toString() => 'CerbereException: $message${code != null ? ' (code: $code)' : ''}';
}
