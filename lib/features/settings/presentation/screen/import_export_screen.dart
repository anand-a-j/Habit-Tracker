import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/constants/constants.dart';
import 'package:habitroot/features/settings/presentation/widgets/settings_card.dart';

import '../../../../core/components/habitroot_appbar.dart';
import '../../../../core/utils/snackbar_manager.dart';
import '../provider/import_export_provider.dart';

class ImportExportScreen extends ConsumerWidget {
  const ImportExportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(importExportProvider);

    ref.listen(importExportProvider, (prev, next) {
      next.whenOrNull(error: (err, _) {
        Snack.error(err.toString());
      }, data: (_) {
        if (prev?.isLoading == true) {
          Snack.success("Operation completed");
        }
      });
    });
    return Scaffold(
      appBar: HabitRootAppBar(
        leadingOnTap: () => context.pop(),
        title: "Data & Backup",
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConsts.pSide,
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppConsts.pLarge),
                  GestureDetector(
                    onTap: () {
                      ref.read(importExportProvider.notifier).importHabits();
                    },
                    child: const SettingsCard(
                      leadingIcon: Assets.import,
                      title: "Import Data",
                      subTitle: "Load habits and backup files into the app",
                      isFirst: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(importExportProvider.notifier).exportHabits();
                    },
                    child: const SettingsCard(
                      leadingIcon: Assets.export,
                      title: "Export Data",
                      subTitle: "Save your habits and backup them securely",
                      isLast: true,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
