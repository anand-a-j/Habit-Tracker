import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/extension/common.dart';

class SettingsCard extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String? subTitle;
  final void Function()? onTap;
  final bool isFirst;
  final bool isLast;

  const SettingsCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subTitle,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    double defaultRadius = 4;
    double largeRadius = 15;

    final borderRadius = BorderRadius.vertical(
      top: Radius.circular(isFirst ? largeRadius : defaultRadius),
      bottom: Radius.circular(isLast ? largeRadius : defaultRadius),
    );
    return Card(
      margin: const EdgeInsets.only(bottom: 2),
      color: context.secondaryFixed,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: SvgPicture.asset(
            leadingIcon,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              context.onPrimary.withValues(alpha: 0.5),
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            title,
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subTitle != null
              ? Text(
                  subTitle!,
                  style: context.bodySmall?.copyWith(
                    color: context.onPrimary.withValues(
                      alpha: 0.5,
                    ),
                  ),
                )
              : null,
          trailing: SvgPicture.asset(
            Assets.arrowRight,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              context.onPrimary.withValues(alpha: 0.5),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}