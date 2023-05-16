// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicalstore/DashboardScreen.dart';
import 'package:medicalstore/DashboardModuleCard.dart';

void main() {
  testWidgets('DashboardScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardScreen()));

    // expect(find.byType(DashboardScreen), findsOneWidget);
    // expect(find.byType(DashboardModuleCard), findsNWidgets(2));
    // expect(find.text('Product Catalog'), findsOneWidget);
  });
}

