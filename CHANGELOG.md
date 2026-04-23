# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [0.2.0+6] - 2026-04-23

### Ajouté

- `RecupereNomRoleUtilisateurUsecase` pour récupérer le nom du rôle assigné à un utilisateur.
- Registre de langues `CerbereLangueRegistry` et enum `CerbereLangueVariable` pour l'internationalisation des libellés (fr / en).
- Mixin `CerbereVerifiable` pour appliquer la vérification de permissions à n'importe quelle classe.
- Extension `CerbereWidgetExtension` (`widget.cerbereVerifie(cle)`) pour appliquer un contrôle de droit à n'importe quel widget.

### Modifié

- `CerbereInitWidget` : enregistrement cohérent des droits et de la langue dans leurs registres respectifs.
- `CerbereDroitsRegistry` : validation des clés uniques et cohérence entre init widgets.
- `CerbereException` : gestion simplifiée du code et du message d'erreur.
- Modèles (`CerbereDroit`, `CerbereRole`, `CerbereUtilisateur`) : dartdoc complétée sur les constructeurs, factories et champs publics.

## [0.1.4+5] - 2025-02-24

### Ajouté

- `screenshots` dans `pubspec.yaml` pour la miniature et la section Screenshots sur Pub.dev.

## [0.1.3+4] - 2025-02-24

### Modifié

- README : image en HTML centrée (raw URL, largeur 400px).

## [0.1.2+3] - 2025-02-24

### Modifié

- README : URL de l'image mise à jour vers le dépôt GitHub Sushy974/cerbere.

## [0.1.1+2] - 2025-02-24

### Ajouté

- Dossier `example/` avec une application exemple pour démontrer l'usage du package.
- Documentation dartdoc sur les constructeurs et types manquants (CerbereDroit, CerbereException, CerbereInitWidget, CerbereDroitsRegistry, CerbereLangue).
- Image du README référencée via l'URL GitHub pour l'affichage sur Pub.dev.

### Modifié

- `CerbereDroitsRegistry` : constructeur privé pour éviter l'instanciation (classe à usage statique).

## [0.1.0+1] - 2025-02-24

### Ajouté

- Gestion des rôles et droits avec Firebase Auth et Firestore.
- `CerbereInitWidget` pour initialiser le package avec une liste de `CerbereDroit`.
- `CerbereWidgetVerifie` pour afficher conditionnellement un widget selon un droit.
- `CerbereService` avec `cerbereVerifie()` et `cerbereStreamVerifie()`.
- Modèles `CerbereDroit`, `CerbereRole`, `CerbereUtilisateur`.
- Repositories Firestore : `FirestoreCerbereRoleRepository`, `FirestoreCerbereUtilisateurRepository`.
- Registry des droits : `CerbereDroitsRegistry`.
- Support multilingue (langues, variables, localisation).
- Exceptions `CerbereException` avec code optionnel.
