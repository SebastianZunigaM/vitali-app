import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand greens ──────────────────────────────────────────────────────────
  static const brandForest    = Color(0xFF145C35);
  static const brandMid       = Color(0xFF1E7A45);
  static const brandMain      = Color(0xFF2BA05F);
  static const brandTurquoise = Color(0xFF35B7A0);
  static const brandBlue      = Color(0xFF38B6D9);

  // ── Surfaces & backgrounds ────────────────────────────────────────────────
  static const background = Color(0xFFF4F7F5);
  static const surface    = Color(0xFFFFFFFF);
  static const inputFill  = Color(0xFFF2F6F3);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const textPrimary   = Color(0xFF22312A);
  static const textSecondary = Color(0xFF5A6E62);
  static const textHint      = Color(0xFF9AA8A0);
  static const textOnGreen   = Color(0xFFFFFFFF);
  static const textSlogan    = Color(0xFFD9F2E3);

  // ── Semantic indicators (color + pastel pair) ─────────────────────────────
  static const water       = Color(0xFF3B82F6);
  static const waterPastel = Color(0xFFE3F1FD);
  static const salt        = Color(0xFFF59E0B);
  static const saltPastel  = Color(0xFFFDF2E0);
  static const sugar       = Color(0xFF8B5CF6);
  static const sugarPastel = Color(0xFFF1EAFD);

  // ── State colors ──────────────────────────────────────────────────────────
  static const successBg           = Color(0xFFDCF2E4);
  static const successText         = Color(0xFF1E7A45);
  static const bannerSuccessBg     = Color(0xFFE7F5EC);
  static const bannerSuccessBorder = Color(0xFF2BA05F);
  static const infoPastel          = Color(0xFFEAF6FD);
  static const tipPastel           = Color(0xFFEFF8F2);
  static const buttonDisabledBg    = Color(0xFFCDEBD9);
  static const buttonDisabledText  = Color(0xFF1E7A45);

  // ── IMC scale ─────────────────────────────────────────────────────────────
  static const imcLow     = Color(0xFF3B82F6);
  static const imcHealthy = Color(0xFF2BA05F);
  static const imcMuted   = Color(0xFFE4ECE7);

  // ── Exercise intensity (bg + text pairs) ──────────────────────────────────
  static const intensitySoftBg       = Color(0xFFDDF0FA);
  static const intensitySoftText     = Color(0xFF2E86C1);
  static const intensityModerateBg   = Color(0xFFD9F2E3);
  static const intensityModerateText = Color(0xFF1E7A45);
  static const intensityHighBg       = Color(0xFFFDE8D2);
  static const intensityHighText     = Color(0xFFE07B2A);

  // ── Gradient color lists ──────────────────────────────────────────────────
  static const gradientAuth            = [brandForest, brandTurquoise];
  static const gradientHeader          = [brandForest, brandMain];
  static const gradientButtonPrimary   = [brandMid, brandMain];
  static const gradientButtonContinue  = [brandMain, brandBlue];
}
