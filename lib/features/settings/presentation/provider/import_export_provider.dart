import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../habit/presentation/provider/habit_provider.dart';
import '../../data/service/import_export_service.dart';

final importExportProvider =
    StateNotifierProvider<ImportExportNotifier, AsyncValue<void>>(
  (ref) => ImportExportNotifier(ref),
);

class ImportExportNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  ImportExportNotifier(this.ref) : super(const AsyncValue.data(null));

  /// EXPORT
  Future<void> exportHabits() async {
    try {
      state = const AsyncValue.loading();

      final habits = ref.read(habitProvider).values.toList();

      await ImportExportService.exportHabit(habits);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// IMPORT
  Future<void> importHabits() async {
    try {
      state = const AsyncValue.loading();

      final imported = await ImportExportService.importHabits();

      // Save to DB
      final notifier = ref.read(habitProvider.notifier);

      for (var h in imported) {
        notifier.updateHabit(h);
      }

      notifier.reloadHabits();

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
