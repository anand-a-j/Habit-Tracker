import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:habitroot/core/constants/app_constants.dart';
import 'package:habitroot/core/extension/common.dart';

class StrengthCard extends StatelessWidget {
  const StrengthCard({super.key, required this.strength});

  final int strength;

  /// Returns color based on strength percentage (4 levels)
  Color _getStrengthColor(int strength) {
    if (strength >= 80) {
      return Colors.green; // Level 4
    } else if (strength >= 60) {
      return Colors.lightGreen; // Level 3
    } else if (strength >= 30) {
      return Colors.orange; // Level 2
    } else {
      return Colors.red; // Level 1
    }
  }

  String _getStrengthMessage(int strength) {
    if (strength >= 80) {
      return "You're doing amazing this is what real consistency looks like. Keep holding that 80% and your habit will become unbreakable!";
    } else if (strength >= 60) {
      return "Strong progress! You're close to the 80% consistency zone. Stay steady and you'll get there soon.";
    } else if (strength >= 30) {
      return "You're building momentum. Keep showing up even small wins push your strength closer to 80%. Stay on track!";
    } else {
      return "Every habit starts with small steps. Aim for consistency, not perfection. Keep moving toward that 80%—you’ve got this!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConsts.pMedium),
      decoration: BoxDecoration(
        color: context.onSecondary,
        borderRadius: BorderRadius.circular(AppConsts.rSmall),
        border: Border.all(
          width: 1,
          color: context.onSecondaryContainer,
        ),
      ),
      child: Column(
        spacing: AppConsts.pMedium,
        children: [
          Text(
            "Strength",
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 200,
            child: DashedCircularProgressBar.aspectRatio(
              aspectRatio: 1,
              progress: strength.toDouble(),
              startAngle: 225,
              sweepAngle: 270,
              foregroundColor: _getStrengthColor(strength),
              backgroundColor: const Color(0xffeeeeee),
              foregroundStrokeWidth: 8,
              backgroundStrokeWidth: 8,
              animation: true,
              seekSize: 3,
              seekColor: const Color(0xffeeeeee),
              child: Center(
                child: Text(
                  '$strength%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 52,
                  ),
                ),
              ),
            ),
          ),
          Text(
            _getStrengthMessage(strength),
            style: context.labelLarge?.copyWith(
              color: context.surface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
