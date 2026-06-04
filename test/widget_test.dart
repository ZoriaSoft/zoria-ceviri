// Smoke test — verifies the app boots and the MaterialApp mounts.
//
// The app wires up SharedPreferences + Drift at startup. We override both
// in the ProviderScope so the test runs without touching the platform
// channel (sqflite). Full integration tests live under integration_test/.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoria_ceviri/app/app.dart';
import 'package:zoria_ceviri/core/providers/providers.dart';
import 'package:zoria_ceviri/data/database/app_database.dart';
import 'package:zoria_ceviri/features/settings/application/settings_controller.dart';
import 'package:drift/native.dart';

class _FakeAppDatabase extends AppDatabase {
  _FakeAppDatabase() : super.forTesting(NativeDatabase.memory());
}

void main() {
  testWidgets('app boots and renders MaterialApp', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();

    final db = _FakeAppDatabase();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          databaseProvider.overrideWithValue(db),
        ],
        child: const ZoriaCeviriApp(),
      ),
    );
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
