import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/extension/common.dart';

class HabitEmptyView extends StatelessWidget {
  final String title;
  final String subtitle;

  const HabitEmptyView({
    super.key,
    // Default values are now general enough for any screen
    this.title = "Ready to Start?",
    this.subtitle =
        "There are no habits to show right now.\nReady to add a new one?",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            // 1. Emoji: "Leaf in the wind"
            // Represents calmness/emptiness without being negative
            const Text(
              "🍃",
              style: TextStyle(
                fontSize: 80,
              ),
            ),
            const SizedBox(height: 8),

            // 2. Universal Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.bodyLarge?.copyWith(
                fontSize: 22,
                color: context.onPrimary,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),

            // 3. Universal Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                color:
                    context.onPrimary.withOpacity(0.7), // Slightly more faded
                height: 1.5,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // 4. Button
            _HabitAddButton(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _HabitAddButton extends StatelessWidget {
  const _HabitAddButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.onPrimary,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          context.pushNamed("habit-add-screen");
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_rounded,
                size: 22,
                color: context.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                "Add Habit",
                style: context.bodySmall?.copyWith(
                  color: context.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
