# Heracles

Package Dart/Flutter pour gérer les rôles et droits avec Firebase.

## Description

Heracles est un package générique qui permet de gérer un système de rôles et de droits basé sur Firebase Auth et Firestore. Il fournit :

- Un système de vérification de permissions
- Des widgets conditionnels basés sur les droits

**Note** : Pour les pages d'administration (gestion des utilisateurs, rôles et droits), utilisez le package `heracles_admin` qui dépend de Firebase Admin SDK.

## Installation

Ajoutez `heracles` à votre `pubspec.yaml` :

```yaml
dependencies:
  heracles:
    path: ../packages/heracles
```

## Initialisation

Dans votre `main.dart`, enveloppez votre application avec `HeraclesInitWidget` :

```dart
import 'package:heracles/heracles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation Firebase
  await Firebase.initializeApp(...);
  
  // Définir la liste des droits disponibles dans votre application
  final droits = [
    'can_edit_users',
    'can_delete_users',
    'can_view_reports',
    // Ajoutez tous vos droits ici
  ];
  
  runApp(
    HeraclesInitWidget(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      droits: droits,
      child: MyApp(),
    ),
  );
}
```

**Important** : La liste des droits doit être identique si vous utilisez à la fois `HeraclesInitWidget` et `HeraclesAdminInitWidget`. Le package vérifie automatiquement la cohérence et lance une exception si les listes diffèrent.

## Structure des collections Firestore

Le package utilise deux collections Firestore :

### `_heracles_roles`

Collection des rôles. Chaque document contient :

```dart
{
  'uid': 'string',
  'nom': 'string',
  'droits': ['can_edit_users', 'can_delete_users', ...] // Liste de clés de droits (strings)
}
```

### `_heracles_utilisateur`

Collection des associations utilisateur-rôle. Chaque document contient :

```dart
{
  'utilisateurUid': 'string', // ID du document = utilisateurUid
  'roleUid': 'string'
}
```

**Note** : Les droits ne sont plus stockés dans Firestore. Ils sont définis dans le code de l'application lors de l'initialisation via `HeraclesInitWidget` ou `HeraclesAdminInitWidget`.

## Utilisation

### Vérification de permissions

#### Avec un widget conditionnel

```dart
HeraclesWidgetVerifie(
  cle: 'can_edit_users',
  child: ElevatedButton(
    onPressed: () {
      // Action autorisée
    },
    child: Text('Éditer les utilisateurs'),
  ),
)
```

#### Avec une vérification manuelle

```dart
final service = context.read<HeraclesService>();

// Vérification synchrone
final hasPermission = await service.heraclesVerifie('can_delete');
if (hasPermission) {
  // Action autorisée
}

// Vérification en temps réel (stream)
service.heraclesStreamVerifie('can_edit').listen((hasPermission) {
  if (hasPermission) {
    // Action autorisée
  }
});
```

### Pages d'administration

## Pages d'administration

Pour utiliser les pages d'administration (`HeraclesUtilisateursPage` et `HeraclesRolesPage`), vous devez utiliser le package `heracles_admin` qui dépend de Firebase Admin SDK.

Voir la documentation de `heracles_admin` pour plus d'informations.

## Définition des droits

Les droits sont définis dans le code de l'application lors de l'initialisation. Il suffit d'ajouter la clé du droit dans la liste passée à `HeraclesInitWidget` ou `HeraclesAdminInitWidget`.

Pour utiliser un droit dans votre code, utilisez simplement sa clé (string) :

```dart
HeraclesWidgetVerifie(
  cle: 'can_edit_users', // La clé définie dans votre liste de droits
  child: ElevatedButton(...),
)
```

## Création de rôles

Les rôles peuvent être créés via la page d'administration `HeraclesRolesPage` ou directement dans Firestore.

## Attribution de rôles aux utilisateurs

Les rôles peuvent être attribués via la page d'administration `HeraclesUtilisateursPage` ou directement dans Firestore.

## Sécurité

**Important** : Ce package ne gère pas la sécurité Firestore. Vous devez configurer les règles Firestore dans votre application pour protéger les collections `_heracles_*`.

Exemple de règles Firestore (à adapter selon vos besoins) :

```javascript
match /_heracles_roles/{document=**} {
  allow read: if request.auth != null;
  allow write: if request.auth != null && 
    // Ajoutez votre logique de vérification ici
    get(/databases/$(database)/documents/_heracles_utilisateur/$(request.auth.uid)).data.roleUid == 'admin_role_uid';
}

match /_heracles_utilisateur/{document=**} {
  allow read: if request.auth != null;
  allow write: if request.auth != null && 
    // Ajoutez votre logique de vérification ici
    get(/databases/$(database)/documents/_heracles_utilisateur/$(request.auth.uid)).data.roleUid == 'admin_role_uid';
}
```

## Licence

Ce package est fourni tel quel, sans garantie.
