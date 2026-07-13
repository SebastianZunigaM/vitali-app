import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

class _Segment {
  final String label;
  final double start;
  final double end;
  final Color activeColor;

  const _Segment({
    required this.label,
    required this.start,
    required this.end,
    required this.activeColor,
  });

  double get units => end - start;
}

const _segments = [
  _Segment(label: 'Bajo', start: 10, end: 18.5, activeColor: AppColors.imcLow),
  _Segment(label: 'Saludable', start: 18.5, end: 25, activeColor: AppColors.imcHealthy),
  _Segment(label: 'Sobrepeso', start: 25, end: 30, activeColor: Color(0xFFF59E0B)),
  _Segment(label: 'Obesidad', start: 30, end: 40, activeColor: Color(0xFFC62828)),
];

const _totalUnits = 30.0; // 40 - 10

class ImcScaleBar extends StatelessWidget {
  final double imcValue;
  final double barHeight;

  const ImcScaleBar({
    super.key,
    required this.imcValue,
    this.barHeight = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBar(),
        const SizedBox(height: 6),
        _buildThresholdLabels(),
      ],
    );
  }

  Widget _buildBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(barHeight / 2),
      child: Row(
        children: _segments.map((seg) {
          final isActive = seg.start < imcValue;
          final flex = (seg.units / _totalUnits * 1000).round();
          return Expanded(
            flex: flex,
            child: Container(
              height: barHeight,
              color: isActive ? seg.activeColor : AppColors.imcMuted,
              child: Center(
                child: Text(
                  seg.label,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textSecondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildThresholdLabels() {
    // Show threshold numbers: 18.5, 25, 30
    const thresholds = [18.5, 25.0, 30.0];
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        return SizedBox(
          height: 16,
          child: Stack(
            children: thresholds.map((t) {
              final fraction = (t - 10) / _totalUnits;
              final x = totalWidth * fraction;
              return Positioned(
                left: x - 14,
                child: Text(
                  t == 18.5 ? '18.5' : t.toInt().toString(),
                  style: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
