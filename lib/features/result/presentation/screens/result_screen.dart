import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../recorder/application/recorder_controller.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final ui = ref.watch(recorderControllerProvider);
    final src = ui.sourceText ?? '';
    final dst = ui.translatedText ?? '';

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          SectionHeader(kicker: l.resultKicker, title: l.resultTitle),
          const SizedBox(height: 18),
          _Block(
            label: l.resultSource,
            text: src,
            accent: AppColors.inkMute,
          ),
          const SizedBox(height: 14),
          _Block(
            label: l.resultTarget,
            text: dst,
            accent: AppColors.amber,
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: src.isEmpty
                      ? null
                      : () => Share.share('$src\n\n—\n\n$dst'),
                  icon: const Icon(Icons.ios_share, size: 18),
                  label: Text(l.resultShare),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: AppColors.background,
                  ),
                  onPressed: () {
                    ref.read(recorderControllerProvider.notifier).clear();
                    Navigator.of(context).pop();
                  },
                  child: Text(l.resultNew),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Block extends StatefulWidget {
  const _Block({required this.label, required this.text, required this.accent});
  final String label;
  final String text;
  final Color accent;
  @override
  State<_Block> createState() => _BlockState();
}

class _BlockState extends State<_Block> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label.toUpperCase(),
            style: TextStyle(
              color: widget.accent,
              fontSize: 11,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.text.isEmpty ? '—' : widget.text,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 17,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
