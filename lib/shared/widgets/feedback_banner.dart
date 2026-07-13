import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

enum FeedbackBannerType { success, error, info }

/// Banner de retroalimentación insertado dentro de formularios.
/// Pantalla 03: variante success — fondo #E7F5EC, borde #2BA05F, texto #1E7A45.
class FeedbackBanner extends StatelessWidget {
  final String message;
  final FeedbackBannerType type;

  const FeedbackBanner({
    super.key,
    required this.message,
    this.type = FeedbackBannerType.success,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(type);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colors.bg,
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: colors.text,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          height: 1.55,
        ),
      ),
    );
  }

  _BannerColors _colorsFor(FeedbackBannerType t) {
    switch (t) {
      case FeedbackBannerType.success:
        return const _BannerColors(
          bg: AppColors.bannerSuccessBg,
          border: AppColors.bannerSuccessBorder,
          text: AppColors.successText,
        );
      case FeedbackBannerType.error:
        return const _BannerColors(
          bg: Color(0xFFFFE5E5),
          border: Color(0xFFE53935),
          text: Color(0xFFC62828),
        );
      case FeedbackBannerType.info:
        return const _BannerColors(
          bg: AppColors.infoPastel,
          border: AppColors.water,
          text: AppColors.water,
        );
    }
  }
}

class _BannerColors {
  final Color bg;
  final Color border;
  final Color text;
  const _BannerColors({required this.bg, required this.border, required this.text});
}
