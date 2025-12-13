import 'package:flutter/material.dart';
import 'package:habitroot/core/constants/app_constants.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/features/premium/presentation/widgets/premium_pay_button.dart';

class PremiumFooter extends StatelessWidget {
  const PremiumFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PremiumPayButton(
            label: "Continue",
            onPressed: () {},
            isDisabled: false,
            isLoading: false,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConsts.pSide,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FooterLinkText(
                  title: "Restore",
                  onTap: () {},
                ),
                _FooterLinkText(
                  title: "Policy",
                  onTap: () {},
                ),
                _FooterLinkText(
                  title: "Terms",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _FooterLinkText extends StatelessWidget {
  const _FooterLinkText({
    required this.title,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: context.bodyMedium?.copyWith(
          color: context.onPrimary.withValues(alpha: 0.5),
          decoration: TextDecoration.underline,
          decorationColor: context.onPrimary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
