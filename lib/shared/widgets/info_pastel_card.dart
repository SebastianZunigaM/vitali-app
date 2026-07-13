import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

class InfoPastelCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String? body;
  final Color backgroundColor;
  final Color titleColor;
  final Color bodyColor;
  final bool boldBody;

  const InfoPastelCard({
    super.key,
    required this.emoji,
    required this.title,
    this.body,
    this.backgroundColor = AppColors.tipPastel,
    this.titleColor = AppColors.textPrimary,
    this.bodyColor = AppColors.textSecondary,
    this.boldBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (body != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    body!,
                    style: TextStyle(
                      color: bodyColor,
                      fontSize: 12,
                      fontWeight: boldBody ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
