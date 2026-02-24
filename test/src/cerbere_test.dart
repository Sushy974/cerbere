// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:cerbere/src/cerbere.dart';

void main() {
  group('Cerbere', () {
    test('can be instantiated', () {
      expect(Cerbere(), isNotNull);
    });
  });
}
