/// Exception personnalisée pour le package Cerbère
class CerbereException implements Exception {
  /// Message d'erreur descriptif
  final String message;

  /// Code d'erreur optionnel
  final String? code;

  /// {@macro cerbere_exception}
  CerbereException(this.message, {this.code});

  @override
  String toString() => 'CerbereException: $message${code != null ? ' (code: $code)' : ''}';
}
