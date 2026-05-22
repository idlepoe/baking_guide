import 'package:get/get.dart';

import '../../data/repositories/progress_session_repository.dart';
import '../../data/repositories/timer_repository.dart';
import '../storage/ingredient_batch_scale_preferences.dart';
import 'timer_schedule_service.dart';

/// 진행 세션·타이머·재료 배율 등 진행 데이터 SharedPreferences 초기화.
class ProgressDataResetService extends GetxService {
  ProgressDataResetService({
    TimerRepository? timerRepository,
    ProgressSessionRepository? sessionRepository,
    TimerScheduleService? timerScheduleService,
    IngredientBatchScalePreferences? ingredientBatchScalePreferences,
  })  : _timerRepository = timerRepository ?? Get.find<TimerRepository>(),
        _sessionRepository =
            sessionRepository ?? Get.find<ProgressSessionRepository>(),
        _timerScheduleService =
            timerScheduleService ?? Get.find<TimerScheduleService>(),
        _ingredientBatchScalePreferences = ingredientBatchScalePreferences ??
            IngredientBatchScalePreferences();

  final TimerRepository _timerRepository;
  final ProgressSessionRepository _sessionRepository;
  final TimerScheduleService _timerScheduleService;
  final IngredientBatchScalePreferences _ingredientBatchScalePreferences;

  Future<void> resetAllProgressData() async {
    final timers = await _timerRepository.loadAll();
    for (final timer in timers) {
      await _timerScheduleService.cancelTimer(timer.timerId);
    }

    await _sessionRepository.clearAll();
    await _timerRepository.clearAll();
    await _ingredientBatchScalePreferences.clearAll();
    await _timerScheduleService.refreshActiveEntries();
  }
}
