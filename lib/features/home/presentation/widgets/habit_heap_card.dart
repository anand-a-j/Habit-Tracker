import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitroot/core/components/core_components.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/enum/date_event.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/extension/habit_extension.dart';
import 'package:habitroot/features/calendar/domain/calendar_event.dart';
import 'package:habitroot/features/calendar/presentation/heap_map_calendar.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../../../../core/enum/habit_card_type.dart';
import '../../../../routes/routes.dart';
import '../../../habit/presentation/provider/habit_provider.dart';
import '../components/habit_details_bottom_sheet.dart';
import 'habit_mark_button.dart';

final heapCardHabitId = Provider<String>((ref) => throw UnimplementedError());

class HabitHeapCard extends ConsumerWidget {
  const HabitHeapCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _size = MediaQuery.sizeOf(context);

    final habitId = ref.watch(heapCardHabitId);
    final habit = ref.watch(habitByIdProvider(habitId));
    final habitColor = habit.color;

    final events = habit.completedDates
        .map((date) => CalendarEvent(
              date: DateTime(date.year, date.month, date.day),
              event: DateEvent.completed,
            ))
        .toList();

    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));
    final startDate =
        habit.createdAt.isBefore(oneYearAgo) ? habit.createdAt : oneYearAgo;
    return GestureDetector(
      onTap: () {
        showHabitDetailsSheet(context, habit);
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            // duration: const Duration(milliseconds: 300),
            // curve: Curves.easeInOut,
            padding: const EdgeInsets.all(AppConsts.pSmall),
            margin: EdgeInsetsDirectional.only(
              start: AppConsts.pSide,
              end: AppConsts.pSide,
              top: AppConsts.pSide,
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
              children: [
                Row(
                  spacing: AppConsts.pSmall,
                  crossAxisAlignment:
                      habit.description != null && habit.description!.isNotEmpty
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                  children: [
                    Text(
                      habit.icon,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: _size.width - 174,
                          child: Text(
                            habit.name,
                            style: context.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (habit.description != null &&
                            habit.description!.isNotEmpty)
                          SizedBox(
                            width: _size.width - 174,
                            child: Text(
                              habit.description ?? "",
                              style: context.labelLarge?.copyWith(
                                color: context.surface,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    HabitMarkButton(
                      backgroundColor: Color(habitColor),
                      habitId: habit.id,
                    ),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: settings.listenable(
                    keys: [habitCardModeKey],
                  ),
                  builder: (context, value, child) {
                    final HabitCardType habitCardType =
                        HabitCardType.values[value.get(
                      habitCardModeKey,
                      defaultValue: 0,
                    )];

                    Widget content;
                    if (HabitCardType.week == habitCardType) {
                      content = const SizedBox.shrink();
                    } else {
                      content = Column(
                        key: const ValueKey("month_view"),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: AppConsts.pMedium),
                          HeatMapCalendar(
                            startDate: startDate,
                            endDate: DateTime.now(),
                            events: events,
                            baseColor: Color(habitColor),
                          ),
                        ],
                      );
                    }

                    return AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: content,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _HabitMarkButton extends ConsumerWidget {
//   const _HabitMarkButton({
//     required this.backgroundColor,
//     required this.habitId,
//   });

//   final Color backgroundColor;
//   final String habitId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isCompletedToday = ref.watch(
//       habitByIdProvider(habitId).select((h) => h.isCompletedToday),
//     );

//     return GestureDetector(
//       onTap: () {
//         HapticFeedback.lightImpact();
//         final habit = ref.read(habitByIdProvider(habitId));
//         final updatedHabit = habit.toggleCompleted();
//         ref.read(habitProvider.notifier).updateHabit(updatedHabit);
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.easeInOut,
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: isCompletedToday
//               ? backgroundColor
//               : backgroundColor.withValues(alpha: 0.2),
//           borderRadius: BorderRadius.circular(AppConsts.rMacro),
//         ),
//         child: const Center(
//           child: SvgBuild(assetImage: Assets.tick),
//         ),
//       ),
//     );
//   }
// }
