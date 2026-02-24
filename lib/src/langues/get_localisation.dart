import 'package:cerbere/src/langues/cerbere_langue.dart';
import 'package:cerbere/src/langues/cerbere_langue_variable.dart';

class GetLocalisation {
  static String getLocalisation(
    CerbereLangue langue,
    CerbereLangueVariable variable,
  ) {
    return switch (langue) {
      CerbereLangue.fr => switch (variable) {
        // Variables d'exemple
        CerbereLangueVariable.exempleTexte1 => 'Exemple de texte 1',
        CerbereLangueVariable.exemple2 => 'Exemple 2',

        // Page gestion des utilisateurs
        CerbereLangueVariable.gestionDesUtilisateurs =>
          'Gestion des utilisateurs',
        CerbereLangueVariable.filtrerUtilisateurs =>
          'Filtrer les utilisateurs',
        CerbereLangueVariable.rechercherParEmail => 'Rechercher par e-mail',
        CerbereLangueVariable.titreUtilisateurs => 'Utilisateurs',
        CerbereLangueVariable.titreRoles => 'Rôles',
        CerbereLangueVariable.titreCerbere => 'Cerbère',
        CerbereLangueVariable.superAdmin => 'Super admin',
        CerbereLangueVariable.email => 'Email',
        CerbereLangueVariable.nom => 'Nom',
        CerbereLangueVariable.role => 'Rôle',
        CerbereLangueVariable.nonDisponible => 'N/A',
        CerbereLangueVariable.selectionner => 'Sélectionner',
        CerbereLangueVariable.aucunRole => 'Aucun rôle',
        CerbereLangueVariable.aucunUtilisateurTrouve =>
          'Aucun utilisateur trouvé',
        CerbereLangueVariable.aucunNeCorrespondRecherche =>
          'Aucun utilisateur ne correspond à la recherche',

        // Page gestion des rôles
        CerbereLangueVariable.gestionDesRoles => 'Gestion des rôles',
        CerbereLangueVariable.creerUnRole => 'Créer un rôle',
        CerbereLangueVariable.aucunRoleMessage => 'Aucun rôle',
        CerbereLangueVariable.creezVotrePremierRole =>
          'Créez votre premier rôle',
        CerbereLangueVariable.droits => 'droit(s)',
        CerbereLangueVariable.supprimerLeRole => 'Supprimer le rôle',
        CerbereLangueVariable.etesVousSurDeVouloirSupprimerLeRole =>
          'Êtes-vous sûr de vouloir supprimer le rôle',

        // Formulaire de rôle
        CerbereLangueVariable.modifierLeRole => 'Modifier le rôle',
        CerbereLangueVariable.creerUnNouveauRole => 'Créer un nouveau rôle',
        CerbereLangueVariable.nomDuRole => 'Nom du rôle',
        CerbereLangueVariable.exempleAdministrateur => 'Ex: Administrateur',
        CerbereLangueVariable.droitsAssocies => 'Droits associés',
        CerbereLangueVariable.aucunDroitDisponible => 'Aucun droit disponible',
        CerbereLangueVariable.toutSelectionner => 'Tout sélectionner',

        // Messages généraux
        CerbereLangueVariable.erreur => 'Erreur',
        CerbereLangueVariable.uneErreurEstSurvenue =>
          'Une erreur est survenue',
        CerbereLangueVariable.reessayer => 'Réessayer',
        CerbereLangueVariable.annuler => 'Annuler',
        CerbereLangueVariable.enregistrer => 'Enregistrer',
        CerbereLangueVariable.supprimer => 'Supprimer',
      },
      CerbereLangue.en => switch (variable) {
        // Variables d'exemple
        CerbereLangueVariable.exempleTexte1 => 'Example text 1',
        CerbereLangueVariable.exemple2 => 'Example 2',

        // Page gestion des utilisateurs
        CerbereLangueVariable.gestionDesUtilisateurs => 'User Management',
        CerbereLangueVariable.filtrerUtilisateurs => 'Filter users',
        CerbereLangueVariable.rechercherParEmail => 'Search by email',
        CerbereLangueVariable.titreUtilisateurs => 'Users',
        CerbereLangueVariable.titreRoles => 'Roles',
        CerbereLangueVariable.titreCerbere => 'Cerbere',
        CerbereLangueVariable.superAdmin => 'Super admin',
        CerbereLangueVariable.email => 'Email',
        CerbereLangueVariable.nom => 'Name',
        CerbereLangueVariable.role => 'Role',
        CerbereLangueVariable.nonDisponible => 'N/A',
        CerbereLangueVariable.selectionner => 'Select',
        CerbereLangueVariable.aucunRole => 'No role',
        CerbereLangueVariable.aucunUtilisateurTrouve => 'No user found',
        CerbereLangueVariable.aucunNeCorrespondRecherche =>
          'No user matches the search',

        // Page gestion des rôles
        CerbereLangueVariable.gestionDesRoles => 'Role Management',
        CerbereLangueVariable.creerUnRole => 'Create a role',
        CerbereLangueVariable.aucunRoleMessage => 'No role',
        CerbereLangueVariable.creezVotrePremierRole =>
          'Create your first role',
        CerbereLangueVariable.droits => 'right(s)',
        CerbereLangueVariable.supprimerLeRole => 'Delete role',
        CerbereLangueVariable.etesVousSurDeVouloirSupprimerLeRole =>
          'Are you sure you want to delete the role',

        // Formulaire de rôle
        CerbereLangueVariable.modifierLeRole => 'Modify role',
        CerbereLangueVariable.creerUnNouveauRole => 'Create a new role',
        CerbereLangueVariable.nomDuRole => 'Role name',
        CerbereLangueVariable.exempleAdministrateur => 'Ex: Administrator',
        CerbereLangueVariable.droitsAssocies => 'Associated rights',
        CerbereLangueVariable.aucunDroitDisponible => 'No right available',
        CerbereLangueVariable.toutSelectionner => 'Select all',

        // Messages généraux
        CerbereLangueVariable.erreur => 'Error',
        CerbereLangueVariable.uneErreurEstSurvenue => 'An error occurred',
        CerbereLangueVariable.reessayer => 'Retry',
        CerbereLangueVariable.annuler => 'Cancel',
        CerbereLangueVariable.enregistrer => 'Save',
        CerbereLangueVariable.supprimer => 'Delete',
      },
    };
  }
}
