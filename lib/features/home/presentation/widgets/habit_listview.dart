import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitroot/features/home/presentation/widgets/habit_empty_view.dart';
import 'package:habitroot/features/home/presentation/widgets/habit_heap_card/habit_heap_card.dart';

import '../../../habit/presentation/provider/habit_provider.dart';

class HabitListView extends ConsumerWidget {
  const HabitListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitIds = ref.watch(
      habitProvider.select(
        (map) {
          final habits = map.values.where((habit) => !habit.isArchived).toList()
            ..sort((a, b) => a.order.compareTo(b.order));

          return habits.map((habit) => habit.id).toList();
        },
      ),
    );

    if (habitIds.isEmpty) {
      return const HabitEmptyView();
    }

    return ListView.builder(
      itemCount: habitIds.length + 1,
      itemBuilder: (context, index) {
        if (index == habitIds.length) {
          return const SizedBox(height: 50);
        }
        final habitId = habitIds[index];

        return ProviderScope(
          overrides: [
            heapCardHabitId.overrideWithValue(habitId),
          ],
          child: const HabitHeapCard(),
        );
      },
    );
  }
}
