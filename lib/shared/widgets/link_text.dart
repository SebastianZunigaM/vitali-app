import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

class LinkText extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback? onTap;
  final double fontSize;

  const LinkText({
    super.key,
    required this.text,
    required this.linkText,
    this.onTap,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          fontFamily: 'Quicksand',
        ),
        children: [
          TextSpan(
            text: linkText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: TextStyle(
              color: AppColors.brandMid,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }
}
