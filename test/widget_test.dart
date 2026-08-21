import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hm_shop/routes/index.dart';

void main() {
  test('app root is a MaterialApp', () {
    expect(getRouteWidget(), isA<MaterialApp>());
  });
}
