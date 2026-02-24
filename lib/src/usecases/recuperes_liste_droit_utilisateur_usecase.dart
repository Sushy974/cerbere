// ignore_for_file: public_member_api_docs

import 'dart:developer';

import 'package:cerbere/cerbere.dart';

class RecuperesListeDroitUtilisateurUsecase {
  RecuperesListeDroitUtilisateurUsecase({
    required CerbereUtilisateurRepository cerbereUtilisateurRepository,
    required CerbereRoleRepository cerbereRoleRepository,
  }) : _cerbereUtilisateurRepository = cerbereUtilisateurRepository,
       _cerbereRoleRepository = cerbereRoleRepository;

  final CerbereUtilisateurRepository _cerbereUtilisateurRepository;

  final CerbereRoleRepository _cerbereRoleRepository;

  Future<List<String>> execute(
    RecuperesListeDroitUtilisateurCommand command,
  ) async {
    final cerbereUtilisateur = await _cerbereUtilisateurRepository
        .getUtilisateurByUid(command.userUid);

    if (cerbereUtilisateur == null) {
      log('Aucun utilisateur trouvé');
      return [];
    }
    final role = await _cerbereRoleRepository.getRoleByUid(
      cerbereUtilisateur.roleUid,
    );
    if (role == null) {
      log('Aucun rôle trouvé');
      throw CerbereException('Aucun rôle trouvé');
    }
    log('Rôle trouvé: ${role.droits}');
    return role.droits;
  }
}

class RecuperesListeDroitUtilisateurCommand {
  RecuperesListeDroitUtilisateurCommand({
    required this.userUid,
  });

  final String userUid;
}
