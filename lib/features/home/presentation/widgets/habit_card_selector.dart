import 'package:flutter/material.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/core/enum/habit_card_type.dart';
import 'package:habitroot/core/extension/color_extension.dart';

import '../../../../routes/routes.dart';

class HabitCardTypeSelector extends StatefulWidget {
  const HabitCardTypeSelector({super.key});

  @override
  State<HabitCardTypeSelector> createState() => _HabitCardTypeSelectorState();
}

class _HabitCardTypeSelectorState extends State<HabitCardTypeSelector> {
  late final ValueNotifier<HabitCardType> _cardTypeNotifier = ValueNotifier(
    HabitCardType.values[settings.get(habitCardModeKey, defaultValue: 0)],
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _cardTypeNotifier,
      builder: (context, selectedType, _) {
        return SegmentedButton<HabitCardType>(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => states.contains(WidgetState.selected)
                  ? context.onPrimary
                  : context.onSecondary,
            ),
            iconColor: WidgetStateProperty.resolveWith<Color>(
              (states) => states.contains(WidgetState.selected)
                  ? context.onPrimary
                  : context.onPrimary,
            ),
          ),
          segments: <ButtonSegment<HabitCardType>>[
            ButtonSegment<HabitCardType>(
              value: HabitCardType.week,
              icon: Icon(
                Icons.calendar_view_week,
                color: selectedType == HabitCardType.week
                    ? context.secondary
                    : context.onPrimary,
              ),
            ),
            ButtonSegment<HabitCardType>(
              value: HabitCardType.month,
              icon: Icon(
                Icons.calendar_today,
                color: selectedType == HabitCardType.month
                    ? context.secondary
                    : context.onPrimary,
              ),
            ),
          ],
          selected: {selectedType},
          onSelectionChanged: (newSelection) {
            final newValue = newSelection.first;
            _cardTypeNotifier.value = newValue;

            // store in hive/settings storage
            settings.put(habitCardModeKey, newValue.index);
          },
          showSelectedIcon: false,
        );
      },
    );
  }
}
