import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';

import '../../../../core/constants/app_constants.dart';

class PremiumPayButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool isLoading;

  const PremiumPayButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isDisabled,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConsts.pSide,
          vertical: AppConsts.pSide,
        ),
        child: SizedBox(
          height: 49,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorScheme.premiumPrimary,
              foregroundColor: AppColorScheme.premiumPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              onPressed();
            },
            child: Text(
              label,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColorScheme.premiumOnPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
