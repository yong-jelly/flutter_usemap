// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_usemap/app/app.dart';
import 'package:flutter_usemap/features/onboarding/presentation/pages/onboarding_page.dart';

void main() {
  testWidgets('Onboarding page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: OnboardingPage(),
        ),
      ),
    );

    // Verify that onboarding page is displayed.
    expect(find.text('환영합니다!'), findsOneWidget);
    expect(find.text('시작하기'), findsOneWidget);
  });
}
