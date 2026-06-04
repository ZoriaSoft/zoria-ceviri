import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

class Translations extends Table {
  TextColumn get id => text()();
  TextColumn get sourceText => text()();
  TextColumn get translatedText => text()();
  TextColumn get sourceLang => text().withLength(min: 1, max: 8)();
  TextColumn get targetLang => text().withLength(min: 1, max: 8)();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Translations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor. Lets the test suite inject an in-memory executor
  /// so widget tests don't touch the pl
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future<List<Translation>> recent({int limit = 100}) {
    return (select(translations)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  Stream<List<Translation>> watchRecent({int limit = 100}) {
    return (select(translations)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .watch();
  }

  Future<int> insertTranslation(TranslationsCompanion entry) {
    return into(translations).insert(entry);
  }

  Future<int> deleteAll() {
    return delete(translations).go();
  }

  Future<int> deleteById(String id) {
    return (delete(translations)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'zoria_ceviri.sqlite'));
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
