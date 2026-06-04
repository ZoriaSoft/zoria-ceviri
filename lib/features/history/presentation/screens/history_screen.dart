import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../application/history_controller.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final asyncList = ref.watch(historyStreamProvider);
    final deleteFn = ref.read(historyDeleteProvider);

    return SafeArea(
      child: asyncList.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.amber),
        ),
        error: (e, _) => Center(
          child: Text('$e', style: const TextStyle(color: AppColors.inkMute)),
        ),
        data: (list) {
          if (list.isEmpty) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                SectionHeader(kicker: l.historyKicker, title: l.historyTitle),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    l.historyEmpty,
                    style: const TextStyle(color: AppColors.inkMute, fontSize: 14),
                  ),
                ),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            itemCount: list.length + 1,
            separatorBuilder: (context, i) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              if (i == 0) {
                return SectionHeader(kicker: l.historyKicker, title: l.historyTitle);
              }
              final e = list[i - 1];
              return _Entry(
                source: e.sourceText,
                translated: e.translatedText,
                sourceLang: e.sourceLang,
                targetLang: e.targetLang,
                onDelete: () => deleteFn(e.id),
              );
            },
          );
        },
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
    required this.source,
    required this.translated,
    required this.sourceLang,
    required this.targetLang,
    required this.onDelete,
  });
  final String source;
  final String translated;
  final String sourceLang;
  final String targetLang;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${sourceLang.toUpperCase()} → ${targetLang.toUpperCase()}',
                style: const TextStyle(
                  color: AppColors.amber,
                  fontSize: 11,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onDelete,
                child: const Icon(Icons.close, size: 18, color: AppColors.inkMute),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(source,
              style: const TextStyle(color: AppColors.ink, fontSize: 15, height: 1.4)),
          const SizedBox(height: 6),
          Text(translated,
              style: const TextStyle(
                color: AppColors.inkMute,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.4,
              )),
        ],
      ),
    );
  }
}
