import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/features/settings/presentation/widgets/settings_card.dart';

import '../../../../core/components/habitroot_appbar.dart';

class ImportExportScreen extends StatelessWidget {
  const ImportExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HabitRootAppBar(
        leadingOnTap: () => context.pop(),
        title: "Data & Backup",
      ),
      body: Column(
        children: [
          SettingsCard(
            leadingIcon: Assets.import,
            title: "Import Data",
            subTitle: "Load habits and backup files into the app",
            isFirst: true,
          ),
          SettingsCard(
            leadingIcon: Assets.export,
            title: "Export Data",
            subTitle: "Save your habits and backup them securely",
            isLast: true,
          ),
        ],
      ),
    );
  }
}
