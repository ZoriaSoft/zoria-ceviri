import 'package:flutter/animation.dart';

/// Centralised motion tokens for Zoria Çeviri.
///
/// Following Emil Kowalski's design engineering principles:
/// - Use custom easings (the built-in curves are too weak).
/// - Animation duration under 300ms for UI feedback.
/// - Asymmetric enter/exit (enter 2x exit).
/// - Only animate transform + opacity (GPU-friendly).
class AppMotion {
  AppMotion._();

  // === Easings ===
  /// Strong ease-out for UI feedback (per Emil: never ease-in for UI).
  static const Curve easeOut = Cubic(0.23, 1, 0.32, 1);

  /// Smooth ease-in-out for on-screen movement.
  static const Curve easeInOut = Cubic(0.77, 0, 0.175, 1);

  /// iOS-like drawer curve.
  static const Curve drawer = Cubic(0.32, 0.72, 0, 1);

  // === Durations ===
  /// 120ms — button press feedback (Emil: 100-160ms range).
  static const Duration press = Duration(milliseconds: 120);

  /// 200ms — recording state transitions (idle <-> recording <-> processing).
  static const Duration recording = Duration(milliseconds: 200);

  /// 220ms — generic state changes (status line text swap, etc).
  static const Duration stateChange = Duration(milliseconds: 220);

  /// 180ms — entry for screens, list items, modals.
  static const Duration enter = Duration(milliseconds: 180);

  /// 90ms — exit, asymmetric to enter (per Emil: make exit faster than enter).
  static const Duration exit = Duration(milliseconds: 90);

  // === Stagger ===
  /// 60ms — delay between sibling entries. Decorative, not blocking.
  static const Duration stagger = Duration(milliseconds: 60);
}
