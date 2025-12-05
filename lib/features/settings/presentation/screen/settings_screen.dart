import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/constants/app_constants.dart';
import 'package:habitroot/core/constants/assets.dart';
import 'package:habitroot/core/constants/strings.dart';

import 'package:habitroot/features/settings/presentation/widgets/settings_card.dart';

import '../../../../core/components/core_components.dart';
import '../../../home/presentation/components/app_premium_tile.dart';
import '../widgets/theme_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HabitRootAppBar(
        leadingOnTap: () => context.pop(),
        title: settingsEn,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppConsts.pSide),
        children: [
          const SizedBox(height: AppConsts.pLarge),

          AppPremiumTile(),
          const SizedBox(height: AppConsts.pLarge),
          // SettingsCard(
          //   leadingIcon: Assets.settings,
          //   title: generalEn,
          //   isFirst: true,
          //   onTap: () {
          //     context.pushNamed('general-screen');
          //   },
          // ),
          SettingsCard(
            leadingIcon: Assets.theme,
            title: "Theme",
            isFirst: true,
            onTap: () {
              showThemeBottomSheet(context);
              // context.pushNamed('theme-screen');
            },
          ),
          SettingsCard(
            leadingIcon: Assets.archive,
            title: arcivedHabitsEn,
            onTap: () {
              context.pushNamed('archive-screen');
            },
          ),
          SettingsCard(
            leadingIcon: Assets.folderUp,
            title: dateImportExportEn,
            onTap: () {
              context.pushNamed('import-export-screen');
            },
          ),
          SettingsCard(
            leadingIcon: Assets.arrowUpDown,
            title: reorderHabitsEn,
            isLast: true,
            onTap: () {
              context.pushNamed('reorder-screen');
            },
          ),
          const SizedBox(height: AppConsts.pLarge),
          SettingsCard(
            isFirst: true,
            leadingIcon: Assets.shield,
            title: privacyPolicyEn,
          ),
          SettingsCard(
            leadingIcon: Assets.newspaper,
            title: termsOfUseEn,
          ),
          SettingsCard(
            leadingIcon: Assets.star,
            title: rateTheAppEn,
          ),
          SettingsCard(
            leadingIcon: Assets.externalLink,
            title: shareTheAppEn,
          ),
          GestureDetector(
            onTap: () {},
            child: SettingsCard(
              isLast: true,
              leadingIcon: Assets.messageSquareDiff,
              title: feedbackEn,
              subTitle: "Tell us what you think or found anything wrong?",
            ),
          ),
        ],
      ),
    );
  }
}
