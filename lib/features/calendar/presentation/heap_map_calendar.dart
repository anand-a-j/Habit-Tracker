import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:habitroot/core/extension/time_extension.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';
import 'package:habitroot/features/calendar/domain/calendar_event.dart';

import '../../../core/enum/date_event.dart';

import 'package:flutter/material.dart';

/// HeatMapCalendar
/// - Always fills the grid (start aligned to Sunday, end aligned to Saturday)
/// - Future days (after endDate) are still shown as cells but visually disabled
/// - Days between [habitStartDate..today] show opacity 0.4 (if inside calendar range)
/// - Completed events or selected date => full opacity 1.0
class HeatMapCalendar extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate; // you pass DateTime.now() — that is fine
  final List<CalendarEvent> events;
  final Color baseColor;

  /// Optional habit start date. If null, defaults to startDate.
  final DateTime? habitStartDate;

  /// Make cell size configurable if you want
  final double cellSize;
  const HeatMapCalendar({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.events,
    this.baseColor = AppColorScheme.primary,
    this.habitStartDate,
    this.cellSize = 10,
  });

  @override
  State<HeatMapCalendar> createState() => _HeatMapCalendarState();
}

class _HeatMapCalendarState extends State<HeatMapCalendar> {
  // mutable so we can re-generate on updates
  late List<List<DateTime>> _weeks;
  late Map<DateTime, DateEvent> _eventMap;
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;

  static final BorderRadius _cellRadius = BorderRadius.circular(1);

  @override
  void initState() {
    super.initState();
    _generateInternalState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // scroll to end so recent weeks are visible
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void didUpdateWidget(covariant HeatMapCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // regenerate unconditionally — safe and simple
    _generateInternalState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _generateInternalState() {
    _weeks = _generateWeeks(widget.startDate, widget.endDate);
    _eventMap = {
      for (final e in widget.events)
        DateTime(e.date.year, e.date.month, e.date.day): e.event
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cellSize = widget.cellSize;
    // height to accommodate 7 rows + margins
    return SizedBox(
      height: cellSize * 7 + 4 * 2 + 13,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_weeks.length, (weekIndex) {
            final week = _weeks[weekIndex];
            return Column(
              children: List.generate(7, (dayIndex) {
                final date = week[dayIndex];
                return _buildCell(date, cellSize);
              }),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCell(DateTime date, double cellSize) {
    final key = DateTime(date.year, date.month, date.day);

    final startOnly = _dateOnly(widget.startDate);
    final endOnly = _dateOnly(widget.endDate);

    // inside the provided calendar range (startDate..endDate)
    final insideRange = !date.isBefore(startOnly) && !date.isAfter(endOnly);

    final eventType = _eventMap[key] ?? DateEvent.normal;

    final DateTime? habitStart = widget.events
        .map((e) => e.date)
        .where((d) => d != null)
        .cast<DateTime>()
        .fold<DateTime?>(null, (prev, date) {
      if (prev == null) return date;
      return date.isBefore(prev) ? date : prev;
    });

    double opacity;
    if (_selectedDate != null && _isSameDay(_selectedDate!, date)) {
      opacity = 1.0;
    } else if (eventType == DateEvent.completed) {
      opacity = 1.0;
    } else if (habitStart != null &&
        date.isAfter(habitStart) &&
        date.isBefore(DateTime.now())) {
      opacity = 0.35;
    } else {
      opacity = 0.2;
    }

    final color = widget.baseColor.withOpacity(opacity);

    return Container(
      margin: const EdgeInsets.all(1.5),
      width: cellSize,
      height: cellSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: _cellRadius,
      ),
    );
  }

  /// Generate weeks from start to end, but align start -> Sunday and end -> Saturday
  /// so we always return full 7-day weeks (including future dates if end is not Saturday).
  List<List<DateTime>> _generateWeeks(DateTime start, DateTime end) {
    final weeks = <List<DateTime>>[];

    // Align start to Sunday (weekday % 7 gives 0 for Sunday if using Dart's weekday % 7 trick)
    final startAligned =
        _dateOnly(start.subtract(Duration(days: start.weekday % 7)));

    // Align end to Saturday
    final endAligned =
        _dateOnly(end.add(Duration(days: 6 - (end.weekday % 7))));

    var current = startAligned;
    while (!current.isAfter(endAligned)) {
      final week =
          List<DateTime>.generate(7, (i) => current.add(Duration(days: i)));
      weeks.add(week);
      current = current.add(const Duration(days: 7));
    }
    return weeks;
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
