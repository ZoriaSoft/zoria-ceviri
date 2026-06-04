import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/motion.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../recorder/application/recorder_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _source = 'auto';
  String _target = 'en';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final ui = ref.watch(recorderControllerProvider);
    final ctrl = ref.read(recorderControllerProvider.notifier);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: SectionHeader(
                kicker: 'Zoria · Çeviri',
                title: l.homeGreeting,
                action: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.inkMute,
                  ),
                  child: Text(l.homeHelp),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                l.homeSubline,
                style: const TextStyle(
                  color: AppColors.inkMute,
                  height: 1.4,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: _LanguagePairBar(
                source: _source,
                target: _target,
                onSwap: () {
                  setState(() {
                    final t = _source;
                    _source = _target;
                    _target = t;
                  });
                },
                onSource: (v) => setState(() => _source = v),
                onTarget: (v) => setState(() => _target = v),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RecordHalo(
                    level: ui.level,
                    state: ui.state,
                    onTapDown: (_) => ctrl.start(),
                    onTapUp: (_) => ctrl.stopAndProcess(
                      sourceLang: _source,
                      targetLang: _target,
                    ),
                    onCancel: ctrl.cancel,
                  ),
                  const SizedBox(height: 28),
                  _StatusLine(ui: ui),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguagePairBar extends StatelessWidget {
  const _LanguagePairBar({
    required this.source,
    required this.target,
    required this.onSwap,
    required this.onSource,
    required this.onTarget,
  });

  final String source;
  final String target;
  final VoidCallback onSwap;
  final ValueChanged<String> onSource;
  final ValueChanged<String> onTarget;

  static const _langs = [
    ('auto', 'Auto'),
    ('tr', 'TR'),
    ('en', 'EN'),
    ('de', 'DE'),
    ('fr', 'FR'),
    ('es', 'ES'),
    ('it', 'IT'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        children: [
          _Picker(label: source, values: _langs, onChanged: onSource),
          _SwapButton(onPressed: onSwap),
          _Picker(
            label: target,
            values: _langs.where((l) => l.$1 != 'auto').toList(),
            onChanged: onTarget,
          ),
        ],
      ),
    );
  }
}

class _SwapButton extends StatefulWidget {
  const _SwapButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<_SwapButton> createState() => _SwapButtonState();
}

class _SwapButtonState extends State<_SwapButton> {
  // Per Emil: every press needs feedback. Rotating the swap icon
  // 180° on tap gives spatial consistency — same gesture, two
  // things visibly swap, motion confirms state.
  int _ticks = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: '',
      onPressed: () {
        setState(() => _ticks++);
        widget.onPressed();
      },
      icon: AnimatedRotation(
        turns: _ticks * 0.5,
        duration: AppMotion.easeOut == Curves.linear
            ? const Duration(milliseconds: 220)
            : const Duration(milliseconds: 220),
        curve: AppMotion.easeOut,
        child: const Icon(Icons.swap_horiz, color: AppColors.amber),
      ),
    );
  }
}

class _Picker extends StatelessWidget {
  const _Picker({required this.label, required this.values, required this.onChanged});
  final String label;
  final List<(String, String)> values;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: label,
          dropdownColor: AppColors.surfaceRaised,
          iconEnabledColor: AppColors.inkMute,
          style: const TextStyle(color: AppColors.ink, fontSize: 14),
          items: values
              .map((v) => DropdownMenuItem(value: v.$1, child: Text(v.$2)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _RecordHalo extends StatefulWidget {
  const _RecordHalo({
    required this.level,
    required this.state,
    required this.onTapDown,
    required this.onTapUp,
    required this.onCancel,
  });

  final double level;
  final RecorderState state;
  final ValueChanged<bool> onTapDown;
  final ValueChanged<bool> onTapUp;
  final VoidCallback onCancel;

  @override
  State<_RecordHalo> createState() => _RecordHaloState();
}

class _RecordHaloState extends State<_RecordHalo> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isRecording = widget.state == RecorderState.recording;
    final isProcessing = widget.state == RecorderState.processing;
    const size = 220.0;
    // Per Emil: ease-out, transform-only animations. Pressed state animates
    // scale; recording state animates inner disc + shadow size.
    final glow = isRecording ? 0.55 + 0.45 * widget.level.clamp(0, 1) : 0.0;
    final innerScale = _pressed ? 0.94 : 1.0;

    return GestureDetector(
      onTapDown: isProcessing ? null : (_) {
        setState(() => _pressed = true);
        widget.onTapDown(true);
      },
      onTapUp: isProcessing ? null : (_) {
        setState(() => _pressed = false);
        widget.onTapUp(true);
      },
      onTapCancel: isProcessing ? null : () {
        setState(() => _pressed = false);
        widget.onCancel();
      },
      onTap: isProcessing ? null : () {},
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring — pure opacity / border. No gradient = GPU-cheap.
            AnimatedContainer(
              duration: AppMotion.recording,
              curve: AppMotion.easeOut,
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.amber.withValues(alpha: 0.04 + glow * 0.10),
                border: Border.all(
                  color: AppColors.amber.withValues(alpha: 0.18 + glow * 0.55),
                  width: 1.4,
                ),
                boxShadow: isRecording
                    ? [
                        BoxShadow(
                          color: AppColors.amber.withValues(alpha: 0.18 + glow * 0.32),
                          blurRadius: 36 + glow * 28,
                          spreadRadius: 2 + glow * 8,
                        ),
                      ]
                    : const [],
              ),
            ),
            // Inner disc — press feedback via scale.
            AnimatedScale(
              duration: AppMotion.press,
              curve: AppMotion.easeOut,
              scale: innerScale,
              child: AnimatedContainer(
                duration: AppMotion.recording,
                curve: AppMotion.easeOut,
                width: size * (0.55 + glow * 0.10),
                height: size * (0.55 + glow * 0.10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isProcessing ? AppColors.inkMute : AppColors.amber,
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: AppMotion.stateChange,
                    switchInCurve: AppMotion.easeOut,
                    switchOutCurve: AppMotion.easeInOut,
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: ScaleTransition(
                        scale: Tween(begin: 0.92, end: 1.0).animate(anim),
                        child: child,
                      ),
                    ),
                    child: isProcessing
                        ? const SizedBox(
                            key: ValueKey('spinner'),
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: AppColors.background,
                            ),
                          )
                        : Icon(
                            key: ValueKey(isRecording ? 'stop' : 'mic'),
                            isRecording ? Icons.stop_rounded : Icons.mic_none,
                            size: 42,
                            color: AppColors.background,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.ui});
  final RecorderUi ui;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    String text;
    switch (ui.state) {
      case RecorderState.idle:
        text = l.stateIdle;
        break;
      case RecorderState.recording:
        text = l.stateRecording(_formatMs(ui.elapsedMs));
        break;
      case RecorderState.processing:
        text = l.stateProcessing;
        break;
      case RecorderState.done:
        text = l.stateDone;
        break;
      case RecorderState.error:
        text = ui.errorMessage ?? l.stateError;
        break;
    }
    return AnimatedSwitcher(
      duration: AppMotion.stateChange,
      switchInCurve: AppMotion.easeOut,
      child: Text(
        text,
        key: ValueKey('${ui.state}_$text'),
        style: const TextStyle(
          color: AppColors.inkMute,
          fontSize: 13,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

String _formatMs(int ms) {
  final s = (ms ~/ 1000).toString().padLeft(2, '0');
  final m = (ms ~/ 60000).toString().padLeft(2, '0');
  return '$m:$s';
}
