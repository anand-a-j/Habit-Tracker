import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitroot/core/enum/weekday.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/core/extension/date_extension.dart';
import 'package:habitroot/core/extension/habit_extension.dart';
import 'package:habitroot/core/extension/time_extension.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../habit/domain/habit.dart';
import '../../../../habit/presentation/provider/habit_provider.dart';

class HabitCardWeekMode extends ConsumerWidget {
  const HabitCardWeekMode({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekDays = _getCurrentWeekDays();
    final habitColor = Color(habit.color);

    return Padding(
      padding: const EdgeInsets.only(
        top: AppConsts.pMedium,
      ),
      child: Row(
        spacing: 6,
        children: List.generate(7, (index) {
          final date = weekDays[index];

          final isCompleted = habit.completedDates.any(
            (d) =>
                d.year == date.year &&
                d.month == date.month &&
                d.day == date.day,
          );

          return Expanded(
            child: _HabitWeekMarkButton(
              backgroundColor: habitColor,
              date: date,
              isCompleted: isCompleted,
              onTap: () {
                HapticFeedback.heavyImpact();
                final updated = habit.toggleCompleted(forDate: date);
                ref.read(habitProvider.notifier).updateHabit(updated);
              },
            ),
          );
        }),
      ),
    );
  }
}

class _HabitWeekMarkButton extends StatelessWidget {
  const _HabitWeekMarkButton({
    required this.backgroundColor,
    required this.date,
    required this.isCompleted,
    this.onTap,
  });

  final Color backgroundColor;
  final DateTime date;
  final bool isCompleted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isToday = date.isSameDay(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 40,
        decoration: BoxDecoration(
          color: isCompleted
              ? backgroundColor
              : backgroundColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(6),
          border: isToday
              ? Border.all(
                  width: 1.2,
                  color: backgroundColor,
                )
              : null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getAbbreviation(date.toWeekday),
                style: context.labelMedium?.copyWith(
                  color: context.surface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date.day.toString(),
                style: context.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<DateTime> _getCurrentWeekDays({DateTime? reference}) {
  final now = reference ?? DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // Convert Monday-based index to Sunday-based
  // Sunday => 0, Monday => 1, ... Saturday => 6
  final int sundayBasedIndex = today.weekday % 7;

  final startOfWeek = today.subtract(
    Duration(days: sundayBasedIndex),
  );

  return List.generate(
    7,
    (index) => startOfWeek.add(Duration(days: index)),
  );
}
