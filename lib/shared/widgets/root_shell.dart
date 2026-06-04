import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/motion.dart';
import '../../l10n/gen/app_localizations.dart';

class RootShell extends StatelessWidget {
  const RootShell({required this.child, super.key});

  final Widget child;

  static const _routes = ['/', '/history', '/settings'];

  int _currentIndex(String loc) {
    if (loc.startsWith('/history')) return 1;
    if (loc.startsWith('/settings')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final loc = GoRouterState.of(context).uri.path;
    final idx = _currentIndex(loc);
    final amber = AppColors.amber;
    final mute = AppColors.inkMute;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: AppColors.hairline)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.mic_none,
                  label: l.navHome,
                  active: idx == 0,
                  accent: amber,
                  mute: mute,
                  onTap: () => context.go(_routes[0]),
                ),
                _NavItem(
                  icon: Icons.history,
                  label: l.navHistory,
                  active: idx == 1,
                  accent: amber,
                  mute: mute,
                  onTap: () => context.go(_routes[1]),
                ),
                _NavItem(
                  icon: Icons.tune,
                  label: l.navSettings,
                  active: idx == 2,
                  accent: amber,
                  mute: mute,
                  onTap: () => context.go(_routes[2]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.accent,
    required this.mute,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final Color accent;
  final Color mute;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _pressed = false;

  // Per Emil: press feedback (scale 0.97) on every pressable. The active tab
  // already indicates selection via amber colour, so we never hold the
  // pressed scale at rest — _pressed is true only while the finger is down.
  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.92 : 1.0;
    final color = widget.active ? widget.accent : widget.mute;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: scale,
              duration: AppMotion.press,
              curve: AppMotion.easeOut,
              child: AnimatedSwitcher(
                duration: AppMotion.stateChange,
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: child,
                ),
                child: Icon(
                  widget.icon,
                  key: ValueKey('${widget.icon}_${widget.active}'),
                  color: color,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: AppMotion.stateChange,
              style: TextStyle(
                color: color,
                fontSize: 11,
                letterSpacing: 0.4,
                fontWeight: widget.active ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}
