import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../application/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(settingsControllerProvider);
    final ctrl = ref.read(settingsControllerProvider.notifier);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          SectionHeader(kicker: l.settingsKicker, title: l.settingsTitle),
          const SizedBox(height: 18),
          _Row(
            label: l.settingsLanguage,
            value: s.locale == 'system' ? l.settingsLangSystem : s.locale.toUpperCase(),
            onTap: () => _pickLocale(context, ctrl, s.locale),
          ),
          _Row(
            label: l.settingsSource,
            value: s.sourceLang,
            onTap: () => _pickLang(context, ctrl, s.sourceLang, isSource: true),
          ),
          _Row(
            label: l.settingsTarget,
            value: s.targetLang,
            onTap: () => _pickLang(context, ctrl, s.targetLang, isSource: false),
          ),
          const SizedBox(height: 28),
          Center(
            child: Text(
              l.settingsFooter,
              style: const TextStyle(color: AppColors.inkMute, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _pickLocale(BuildContext context, SettingsController ctrl, String current) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _sheetItem(ctx, 'system', 'System', current, () {
                ctrl.setLocale('system');
                Navigator.pop(ctx);
              }),
              _sheetItem(ctx, 'tr', 'Türkçe', current, () {
                ctrl.setLocale('tr');
                Navigator.pop(ctx);
              }),
              _sheetItem(ctx, 'en', 'English', current, () {
                ctrl.setLocale('en');
                Navigator.pop(ctx);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetItem(BuildContext ctx, String value, String label, String current, VoidCallback onTap) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: AppColors.ink)),
      trailing: value == current
          ? const Icon(Icons.check, color: AppColors.amber)
          : null,
      onTap: onTap,
    );
  }

  void _pickLang(BuildContext context, SettingsController ctrl, String current, {required bool isSource}) {
    const langs = ['auto', 'tr', 'en', 'de', 'fr', 'es', 'it'];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: langs
                .map((code) => _sheetItem(ctx, code, code.toUpperCase(), current, () {
                      if (isSource) {
                        ctrl.setSource(code);
                      } else if (code != 'auto') {
                        ctrl.setTarget(code);
                      }
                      Navigator.pop(ctx);
                    }))
                .toList(),
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, required this.onTap});
  final String label;
  final String value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hairline),
      ),
      child: ListTile(
        title: Text(label, style: const TextStyle(color: AppColors.ink)),
        trailing: Text(value, style: const TextStyle(color: AppColors.amber)),
        onTap: onTap,
      ),
    );
  }
}
