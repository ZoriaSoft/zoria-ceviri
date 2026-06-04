import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/history_repository.dart';
import '../../data/repositories/transcription_repository.dart';
import '../network/api_client.dart';

/// Override at app start with the actual database instance.
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Override databaseProvider in ProviderScope');
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final transcriptionRepositoryProvider = Provider<TranscriptionRepository>((ref) {
  return TranscriptionRepository(ref.read(apiClientProvider));
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(ref.read(databaseProvider));
});
