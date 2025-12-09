import 'package:flutter/material.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';
import 'package:habitroot/features/premium/presentation/widgets/premium_feature_tile.dart';
import 'package:habitroot/features/premium/presentation/widgets/premium_footer.dart';
import 'package:habitroot/features/premium/presentation/widgets/premium_plan_listview.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.pSide,
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: context.onPrimary,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: context.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "HabitBud Pro",
                style: context.titleMedium?.copyWith(
                  color: AppColorScheme.premiumPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Unlock all features with HabitDock Pro",
                style: context.bodySmall?.copyWith(
                  color: context.onPrimary.withValues(alpha: 0.65),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              Center(
                child: Text(
                  "Premium Features",
                  style: context.bodyLarge?.copyWith(
                    color: context.onPrimary,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.onSecondary,
                  borderRadius: BorderRadius.circular(AppConsts.rSmall),
                  border: Border.all(
                    width: 1,
                    color: context.onSecondaryContainer,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    // const SizedBox(height: 6),
                    PremiumFeatureTile(
                      color: Colors.amber,
                      icon: Icons.all_inclusive,
                      title: "Unlimited Habits",
                      subTitle:
                          "Create all the habits you want. No limits, ever!",
                    ),
                    PremiumFeatureTile(
                      color: Colors.green,
                      icon: Icons.auto_graph,
                      title: "Advanced Insights",
                      subTitle:
                          "See deeper stats and understand how you're improving.",
                    ),
                    PremiumFeatureTile(
                      color: Colors.pinkAccent,
                      icon: Icons.brush,
                      title: "Custom Habit Icons",
                      subTitle:
                          "Pick from many icons to personalize every habit.",
                    ),
                    PremiumFeatureTile(
                      color: Colors.blueAccent,
                      icon: Icons.notifications_active,
                      title: "Smart Reminders",
                      subTitle:
                          "Reminders that adjust with your activity and timing.",
                    ),
                    PremiumFeatureTile(
                      color: Colors.deepPurple,
                      icon: Icons.auto_awesome,
                      title: "Premium Themes",
                      subTitle:
                          "Unlock beautiful colors to make your app feel yours.",
                    ),
                    PremiumFeatureTile(
                      color: Colors.teal,
                      icon: Icons.backup,
                      title: "Cloud Backup",
                      subTitle:
                          "Your habits are safely stored and synced forever.",
                    ),
                    PremiumFeatureTile(
                      color: Colors.redAccent,
                      icon: Icons.lock,
                      title: "Lock with App Security",
                      subTitle:
                          "Keep your habits private with PIN or biometrics.",
                    ),
                    PremiumFeatureTile(
                      color: Colors.orangeAccent,
                      icon: Icons.emoji_events,
                      title: "Exclusive Badges",
                      subTitle: "Earn special milestone badges as you grow.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Choose Your Plan",
                style: context.bodyLarge?.copyWith(
                  color: context.onPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              const SizedBox(height: 10),
              PremiumPlanListview(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PremiumFooter(),
    );
  }
}
