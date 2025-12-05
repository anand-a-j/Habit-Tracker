import 'package:flutter/material.dart';
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
    return Card(
      margin: const EdgeInsets.only(bottom: 2),
      color: AppColorScheme.premiumPrimary,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            Icons.diamond_outlined,
            size: 36,
            color: AppColorScheme.premiumOnPrimary,
          ),

          // SvgPicture.asset(
          //   leadingIcon,
          //   width: 24,
          //   height: 24,
          //   fit: BoxFit.contain,
          //   colorFilter: ColorFilter.mode(
          //     context.onPrimary.withValues(alpha: 0.5),
          //     BlendMode.srcIn,
          //   ),
          // ),
          title: Text(
            "HabitDock Pro",
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColorScheme.premiumOnPrimary,
            ),
          ),
          subtitle: Text(
            "Get the pro version to unlock all the features",
            style: context.bodySmall?.copyWith(
              color: AppColorScheme.premiumOnPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
