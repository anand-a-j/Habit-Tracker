import 'package:flutter/material.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';

class AppPremiumButton extends StatelessWidget with AppColorScheme {
  const AppPremiumButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColorScheme.premiumPrimary,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Icon(
              Icons.diamond_outlined,
              color: AppColorScheme.premiumOnPrimary,
              size: 16,
            ),
            Text(
              "Pro",
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColorScheme.premiumOnPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
