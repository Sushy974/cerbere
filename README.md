# Cerbère

<p align="center">
  <img src="https://raw.githubusercontent.com/Sushy974/cerbere/main/assets/images/cerbere.png" alt="Cerbère Admin" width="400" />
</p>

Package Dart/Flutter pour gérer les rôles et les droits avec Firebase Auth et Firestore.

## Description

Cerbère est un package qui permet de gérer un système de rôles et de droits basé sur Firebase Auth et Firestore. Il fournit notamment :

- Un **registre de droits** avec modèles `CerbereDroit` (clé, nom, description)
- Une **vérification de permissions** synchrone ou en stream via `CerbereService`
- Des **widgets conditionnels** selon les droits (`CerbereWidgetVerifie`)
- Des **repositories** Firestore pour rôles et utilisateurs (`_cerbere_roles`, `_cerbere_utilisateur`)

**Pour gérer tout cela** (droits, rôles, utilisateurs) via une interface d’administration, utilisez le package complémentaire [**cerbere_admin**](https://pub.dev/packages/cerbere_admin) sur Pub.dev.

## Installation

Ajoutez `cerbere` à votre `pubspec.yaml` :

```yaml
dependencies:
  cerbere: ^0.1.0
```

Puis :

```bash
flutter pub get
```

## Initialisation

Dans votre `main.dart`, enveloppez votre application avec `CerbereInitWidget` :

```dart
import 'package:cerbere/cerbere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Firebase
  await Firebase.initializeApp(...);

  // Liste des droits disponibles (CerbereDroit : cle, nom, description)
  final droits = [
    CerbereDroit(
      cle: 'can_edit_users',
      nom: 'Éditer les utilisateurs',
      description: 'Permet d\'éditer les utilisateurs',
    ),
    CerbereDroit(
      cle: 'can_delete_users',
      nom: 'Supprimer les utilisateurs',
      description: 'Permet de supprimer les utilisateurs',
    ),
    // Ajoutez tous vos droits ici
  ];

  runApp(
    CerbereInitWidget(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      droits: droits,
      child: MyApp(),
    ),
  );
}
```

**Important** : Si vous utilisez un autre widget d’initialisation (par exemple pour un back-office), la liste des droits doit être la même. Le package vérifie la cohérence et lance une exception si les listes diffèrent.

## Structure des collections Firestore

Le package utilise deux collections Firestore :

### `_cerbere_roles`

Collection des rôles. Chaque document contient :

```dart
{
  'uid': 'string',
  'nom': 'string',
  'droits': ['can_edit_users', 'can_delete_users', ...] // Liste de clés de droits (strings)
}
```

### `_cerbere_utilisateur`

Collection des associations utilisateur–rôle. Chaque document contient :

```dart
{
  'utilisateurUid': 'string', // ID du document = utilisateurUid
  'roleUid': 'string'
}
```

Les droits ne sont pas stockés dans Firestore ; ils sont définis dans le code via `CerbereInitWidget` (liste de `CerbereDroit`).

## Utilisation

### Vérification de permissions

#### Avec un widget conditionnel

```dart
CerbereWidgetVerifie(
  cle: 'can_edit_users',
  child: ElevatedButton(
    onPressed: () {
      // Action autorisée
    },
    child: Text('Éditer les utilisateurs'),
  ),
)
```

Vous pouvez optionnellement fournir `loadingWidget` et `deniedWidget`.

#### Avec une vérification manuelle

```dart
final service = context.read<CerbereService>();

// Vérification synchrone
final hasPermission = await service.cerbereVerifie('can_delete_users');
if (hasPermission) {
  // Action autorisée
}

// Vérification en temps réel (stream)
service.cerbereStreamVerifie('can_edit_users').listen((hasPermission) {
  if (hasPermission) {
    // Action autorisée
  }
});
```

### Définition des droits

Les droits sont définis à l’initialisation sous forme de liste de `CerbereDroit` (cle, nom, description). Pour vérifier un droit dans le code, utilisez sa **clé** (string) :

```dart
CerbereWidgetVerifie(
  cle: 'can_edit_users',
  child: ElevatedButton(...),
)
```

### Création de rôles et attribution aux utilisateurs

Pour **gérer tout cela** (créer/éditer les rôles, attribuer les rôles aux utilisateurs), utilisez le package complémentaire [**cerbere_admin**](https://pub.dev/packages/cerbere_admin), qui fournit une interface d’administration (pages utilisateurs, rôles, droits). Sinon, les rôles peuvent être créés et assignés via les repositories exposés par ce package (`CerbereRoleRepository`, `CerbereUtilisateurRepository`) ou directement dans Firestore.

## Sécurité

Ce package ne gère pas les règles Firestore. Vous devez configurer les règles dans votre projet pour protéger les collections `_cerbere_*`.

Exemple de règles (à adapter) :

```javascript
match /_cerbere_roles/{document=**} {
  allow read: if request.auth != null;
  allow write: if request.auth != null
    && /* votre logique (ex. rôle admin) */;
}

match /_cerbere_utilisateur/{document=**} {
  allow read: if request.auth != null;
  allow write: if request.auth != null
    && /* votre logique */;
}
```

## Licence

Voir le fichier [LICENSE](LICENSE) à la racine du dépôt.
