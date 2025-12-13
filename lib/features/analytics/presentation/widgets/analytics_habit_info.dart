import 'package:flutter/material.dart';
import 'package:habitroot/core/extension/common.dart';
import 'package:habitroot/features/habit/domain/habit.dart';

import '../../../../core/constants/app_constants.dart';

class AnalyticsHabitInfo extends StatelessWidget {
  const AnalyticsHabitInfo({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(AppConsts.pSmall),
        decoration: BoxDecoration(
          color: context.onSecondary,
          borderRadius: BorderRadius.circular(AppConsts.rSmall),
          border: Border.all(
            width: 1,
            color: context.onSecondaryContainer,
          ),
        ),
        child: Row(
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
                Text(
                  habit.name,
                  style: context.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ));
  }
}
