import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/components/core_components.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/extension/common.dart';

import '../../../../core/utils/date_helper.dart';
import '../components/app_premium_button.dart';
import '../widgets/dash_add_habit_button.dart';
import '../widgets/habit_card_selector.dart';
import '../widgets/habit_heap_card.dart';
import '../widgets/habit_listview.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parts = DateHelper.formatDateParts(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.white),
            children: [
              TextSpan(
                text: parts.day,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.onPrimary,
                ),
              ),
              TextSpan(
                text: " ${parts.month} ",
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: parts.year,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.onPrimary,
                ),
              ),
            ],
          ),
        ),
        actions: [
          AppPremiumButton(),
          const SizedBox(width: AppConsts.pMedium),
          GestureDetector(
            onTap: () => context.pushNamed('analytics-screen'),
            child: const SvgBuild(assetImage: Assets.analytics),
          ),
          const SizedBox(width: AppConsts.pMedium),
          GestureDetector(
            onTap: () => context.pushNamed('settings-screen'),
            child: const SvgBuild(assetImage: Assets.settings),
          ),
          const SizedBox(width: AppConsts.pSide),
        ],
      ),
      body: HabitListView(
        cardBuilder: (id) => HabitHeapCard(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 40,
            ),
            child: HabitCardTypeSelector(),
          ),
          DashAddHabitButton(),
        ],
      ),
    );
  }
}
