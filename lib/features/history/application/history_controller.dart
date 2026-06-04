import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/translation_dto.dart';

final historyStreamProvider = StreamProvider<List<TranslationDto>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchRecent().map(
        (rows) => rows
            .map(
              (row) => TranslationDto(
                id: row.id,
                sourceText: row.sourceText,
                translatedText: row.translatedText,
                sourceLang: row.sourceLang,
                targetLang: row.targetLang,
                durationMs: row.durationMs,
                createdAt: row.createdAt,
              ),
            )
            .toList(growable: false),
      );
});

final historyDeleteProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return (String id) async => db.deleteById(id);
});

final historyClearProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return () async => db.deleteAll();
});
