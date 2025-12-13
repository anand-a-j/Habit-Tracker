import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';
import 'package:habitroot/features/analytics/presentation/utils/stats_utils.dart';
import 'package:habitroot/features/analytics/presentation/widgets/analytics_habit_info.dart';
import 'package:habitroot/features/analytics/presentation/widgets/overall_info_card.dart';

import '../../../../core/components/core_components.dart';
import '../../../habit/domain/habit.dart';
import '../../../habit/presentation/provider/habit_provider.dart';
import '../widgets/heat_map_calender.dart';
import '../widgets/strength_card.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({
    this.habit,
    super.key,
  });

  /// If [habit] is null, show overall analytics; otherwise show single habit analytics.
  final Habit? habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("passing habit ; ${habit?.name}");
    // Determine metrics source
    final isSingle = habit != null;
    final displayHabits = isSingle
        ? [habit!]
        : ref.watch(
            habitProvider.select(
              (map) {
                final list = map.values.where((h) => !h.isArchived).toList()
                  ..sort((a, b) => a.order.compareTo(b.order));
                return list;
              },
            ),
          );

    return Scaffold(
      appBar: HabitRootAppBar(
        leadingOnTap: () => context.pop(),
        title: analyticsEn,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(
              // vertical: 6,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: context.onSecondary,
              borderRadius: BorderRadius.circular(AppConsts.rCircle),
              border: Border.all(
                width: 1,
                color: context.onSecondaryContainer,
              ),
            ),
            child: Center(
              child: Text(
                "60 Days",
                style: context.bodySmall?.copyWith(
                  color: context.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConsts.pSide)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: AppConsts.pLarge,
          right: AppConsts.pSide,
          left: AppConsts.pSide,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          if (isSingle) ...[
            AnalyticsHabitInfo(habit: habit!),
            const SizedBox(height: AppConsts.pMedium),
          ],
          StrengthCard(
            strength: StatsUtils.calOverallStrength(displayHabits),
          ),
          const SizedBox(height: AppConsts.pMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: AppConsts.pMedium,
            children: [
              Expanded(
                child: OverallInfoCard(
                  title: "Total Completion",
                  value:
                      StatsUtils.calTotalCompletion(displayHabits).toString(),
                ),
              ),
              Expanded(
                child: OverallInfoCard(
                  title: "Consistency",
                  value:
                      "${StatsUtils.calConsistencyPercentage(displayHabits).toStringAsFixed(2)}%",
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConsts.pMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: AppConsts.pMedium,
            children: [
              Expanded(
                child: OverallInfoCard(
                  title: "Current Streak",
                  value:
                      "${StatsUtils.calOverallCurrentStreak(displayHabits)} days",
                ),
              ),
              Expanded(
                child: OverallInfoCard(
                  title: "Best Streak",
                  value:
                      "${StatsUtils.calOverallBestStreak(displayHabits)} days",
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConsts.pSide),
          Text(
            "Habit Heatmap",
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppConsts.pMedium),
          HeatMapCalender(
            habits: displayHabits,
            primaryColor:
                isSingle ? Color(habit!.color) : AppColorScheme.primary,
          ),
          const SizedBox(height: AppConsts.pSide),
          // Text(
          //   "Average Strength",
          //   style: context.bodyMedium?.copyWith(
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // const SizedBox(height: AppConsts.pMedium),
          // StrengthLineChart(habits: displayHabits),
          // const SizedBox(height: AppConsts.pMedium),
        ],
      ),
    );
  }
}
