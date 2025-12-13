import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/extension/common.dart';

class OnboardingButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.label,
    required this.onPressed,
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
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                color: context.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}


   // // 5. Call to Action (CTA) Button
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 32.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 56,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         // TODO: Implement navigation to the main app screen
              //         print('Start Growing! tapped');
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: primaryGreen,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(14),
              //         ),
              //       ),
              //       child: const Text(
              //         'Start Growing!',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black87),
              //       ),
              //     ),
              //   ),
              // ),