import 'package:cerbere/cerbere.dart';

/// Use case qui récupère le nom du rôle associé à un utilisateur
/// à partir de son UID Firebase Auth.
class RecupereNomRoleUtilisateurUsecase {
  /// Crée le use case avec les repositories nécessaires.
  RecupereNomRoleUtilisateurUsecase({
    required CerbereUtilisateurRepository cerbereUtilisateurRepository,
    required CerbereRoleRepository cerbereRoleRepository,
  }) : _cerbereUtilisateurRepository = cerbereUtilisateurRepository,
       _cerbereRoleRepository = cerbereRoleRepository;

  final CerbereUtilisateurRepository _cerbereUtilisateurRepository;
  final CerbereRoleRepository _cerbereRoleRepository;

  /// Exécute le use case pour l'utilisateur [userUid].
  ///
  /// Retourne le nom du rôle si trouvé, `null` si l'utilisateur n'a
  /// pas de rôle assigné ou si [userUid] est vide.
  Future<String?> execute(String userUid) async {
    if (userUid.isEmpty) return null;

    final cerbereUser = await _cerbereUtilisateurRepository.getUtilisateurByUid(
      userUid,
    );
    if (cerbereUser == null) return null;

    final role = await _cerbereRoleRepository.getRoleByUid(cerbereUser.roleUid);
    return role?.nom;
  }
}
