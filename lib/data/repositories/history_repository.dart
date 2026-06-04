import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../models/translation_dto.dart';

class HistoryRepository {
  HistoryRepository(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Stream<List<TranslationDto>> watchAll() {
    return _db.watchRecent().map(
          (rows) => rows.map(_toDto).toList(growable: false),
        );
  }

  Future<TranslationDto> add({
    required String sourceText,
    required String translatedText,
    required String sourceLang,
    required String targetLang,
    required int durationMs,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.insertTranslation(
      TranslationsCompanion.insert(
        id: id,
        sourceText: sourceText,
        translatedText: translatedText,
        sourceLang: sourceLang,
        targetLang: targetLang,
        durationMs: Value(durationMs),
        createdAt: now,
      ),
    );
    return TranslationDto(
      id: id,
      sourceText: sourceText,
      translatedText: translatedText,
      sourceLang: sourceLang,
      targetLang: targetLang,
      durationMs: durationMs,
      createdAt: now,
    );
  }

  Future<void> clear() => _db.deleteAll();
  Future<void> remove(String id) => _db.deleteById(id);

  TranslationDto _toDto(Translation row) => TranslationDto(
        id: row.id,
        sourceText: row.sourceText,
        translatedText: row.translatedText,
        sourceLang: row.sourceLang,
        targetLang: row.targetLang,
        durationMs: row.durationMs,
        createdAt: row.createdAt,
      );
}
