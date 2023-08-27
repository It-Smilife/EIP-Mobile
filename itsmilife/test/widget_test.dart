// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:itsmilife/main.dart';

int add(int a, int b) {
  return a + b;
}

void main() {
  test('Test d\'addition basique', () {
    int num1 = 5;
    int num2 = 7;
    int result = add(num1, num2);
    expect(result, 12);
  });
}
