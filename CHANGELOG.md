# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

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
