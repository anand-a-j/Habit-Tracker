import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/habitroot_appbar.dart';
import '../../../../core/constants/app_constants.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HabitRootAppBar(
        leadingOnTap: () => context.pop(),
        title: "General",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.pSide,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppConsts.pLarge),
              // GeneralCard(
              //   title: "Week Starts On",
              //   isFirst: true,
              //   onTap: () {
              //     showWeekStartBottomSheet(context);
              //   },
              //   trailing: ValueListenableBuilder(
              //     valueListenable: settings.listenable(keys: [weekStartKey]),
              //     builder: (context, box, child) {
              //       final weekStarts = startWeekdays.elementAt(
              //         settings.get(weekStartKey, defaultValue: 0),
              //       );
              //       return Text(
              //         weekStarts,
              //         style: context.bodyMedium?.copyWith(
              //           fontWeight: FontWeight.w500,
              //           color: context.onPrimary.withValues(alpha: 0.5),
              //         ),
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
