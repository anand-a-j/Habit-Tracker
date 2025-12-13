import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';

class AppPremiumTile extends StatelessWidget {
  final void Function()? onTap;

  const AppPremiumTile({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double largeRadius = 15;

    final borderRadius = BorderRadius.vertical(
      top: Radius.circular(largeRadius),
      bottom: Radius.circular(largeRadius),
    );
    return GestureDetector(
      onTap: () {
        context.pushNamed('premium-screen');
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 2),
        color: AppColorScheme.premiumPrimary,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            leading: const Icon(
              Icons.diamond_outlined,
              size: 32,
              color: AppColorScheme.premiumOnPrimary,
              grade: 0,
            ),
            title: Text(
              "HabitBud Pro",
              style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColorScheme.premiumOnPrimary,
                  height: 1),
            ),
            subtitle: Text(
              "Get the pro version to unlock all the features",
              style: context.bodySmall?.copyWith(
                color: AppColorScheme.premiumOnPrimary,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
