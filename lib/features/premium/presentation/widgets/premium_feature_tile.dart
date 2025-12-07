import 'package:flutter/material.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/extension/textstyle_extension.dart';

class PremiumFeatureTile extends StatelessWidget {
  const PremiumFeatureTile({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color.withValues(alpha: 0.2),
          ),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, color: color),
              ),
              Text(
                subTitle,
                style: context.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.onPrimary,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}