import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/font_scale_service.dart';
import '../../../core/services/tutorial_guide_service.dart';
import '../../../core/services/tutorial_guide_log.dart';
import '../../../core/services/progress_data_reset_service.dart';
import '../../../core/services/timer_schedule_service.dart';
import '../../../core/services/wakelock_service.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../progress_list/controllers/progress_list_controller.dart';
import '../../../core/storage/first_launch_preferences.dart';
import '../../../core/storage/screen_wake_preferences.dart';
import '../../../core/storage/theme_preferences.dart';
import '../../../core/storage/timer_notification_preferences.dart';
import '../../../core/theme/app_seed_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../widgets/app_info_dialog.dart';
import '../widgets/font_size_bottom_sheet.dart';
import '../widgets/notification_sound_bottom_sheet.dart';
import '../widgets/theme_color_bottom_sheet.dart';

class SettingsController extends GetxController {
  static const contactEmail = 'idlepoe@gmail.com';
  SettingsController({
    ThemePreferences? themePreferences,
    ScreenWakePreferences? screenWakePreferences,
    FirstLaunchPreferences? firstLaunchPreferences,
    TimerNotificationPreferences? timerNotificationPreferences,
    WakelockService? wakelockService,
    AppThemeController? appThemeController,
    FontScaleService? fontScaleService,
    TimerScheduleService? timerScheduleService,
    ProgressDataResetService? progressDataResetService,
  }) : _themePreferences = themePreferences ?? Get.find<ThemePreferences>(),
       _screenWakePreferences =
           screenWakePreferences ?? Get.find<ScreenWakePreferences>(),
       _firstLaunchPreferences =
           firstLaunchPreferences ?? FirstLaunchPreferences(),
       _timerNotificationPreferences =
           timerNotificationPreferences ??
           Get.find<TimerNotificationPreferences>(),
       _wakelockService = wakelockService ?? Get.find<WakelockService>(),
       _appThemeController =
           appThemeController ?? Get.find<AppThemeController>(),
       _fontScaleService = fontScaleService ?? Get.find<FontScaleService>(),
       _timerScheduleService =
           timerScheduleService ?? Get.find<TimerScheduleService>(),
       _progressDataResetService =
           progressDataResetService ??
           (Get.isRegistered<ProgressDataResetService>()
               ? Get.find<ProgressDataResetService>()
               : ProgressDataResetService());

  final ThemePreferences _themePreferences;
  final ScreenWakePreferences _screenWakePreferences;
  final FirstLaunchPreferences _firstLaunchPreferences;
  final TimerNotificationPreferences _timerNotificationPreferences;
  final WakelockService _wakelockService;
  final AppThemeController _appThemeController;
  final FontScaleService _fontScaleService;
  final TimerScheduleService _timerScheduleService;
  final ProgressDataResetService _progressDataResetService;

  final isDarkMode = false.obs;
  final keepScreenOn = true.obs;
  final timerNotificationsEnabled = true.obs;
  final vibrationEnabled = true.obs;
  final notificationSound = TimerNotificationSound.defaultSound.obs;
  final isFirstLaunch = true.obs;

  String get selectedSeedLabel {
    final seed = _appThemeController.seedColor.value;
    return AppSeedColors.labelFor(seed).label;
  }

  String get selectedFontSizeLabel => _fontScaleService.fontScale.value.label;

  String get notificationSoundLabel => notificationSound.value.label;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _appThemeController.themeMode.value == ThemeMode.dark;
    _syncFromStorage();
  }

  Future<void> _syncFromStorage() async {
    final storedDark = await _themePreferences.loadIsDarkMode();
    isDarkMode.value = storedDark;

    final mode = storedDark ? ThemeMode.dark : ThemeMode.light;
    if (_appThemeController.themeMode.value != mode) {
      _appThemeController.setThemeMode(mode);
    }

    final storedWake = await _screenWakePreferences.loadEnabled();
    keepScreenOn.value = storedWake;
    await _wakelockService.setEnabled(storedWake);

    timerNotificationsEnabled.value = await _timerNotificationPreferences
        .loadNotificationsEnabled();
    vibrationEnabled.value = await _timerNotificationPreferences
        .loadVibrationEnabled();
    notificationSound.value = await _timerNotificationPreferences
        .loadSoundOption();
    isFirstLaunch.value = await _firstLaunchPreferences.loadIsFirstLaunch();
  }

  Future<void> setDarkMode(bool enabled) async {
    isDarkMode.value = enabled;
    _appThemeController.setThemeMode(
      enabled ? ThemeMode.dark : ThemeMode.light,
    );
    await _themePreferences.saveIsDarkMode(enabled);
  }

  Future<void> setKeepScreenOn(bool enabled) async {
    keepScreenOn.value = enabled;
    await _wakelockService.setEnabled(enabled);
    await _screenWakePreferences.saveEnabled(enabled);
  }

  Future<void> setTimerNotificationsEnabled(bool enabled) async {
    timerNotificationsEnabled.value = enabled;
    await _timerNotificationPreferences.saveNotificationsEnabled(enabled);
    if (enabled) {
      await _timerScheduleService.applyGlobalNotificationsEnabled();
    } else {
      await _timerScheduleService.applyGlobalNotificationsDisabled();
    }
  }

  Future<void> setVibrationEnabled(bool enabled) async {
    vibrationEnabled.value = enabled;
    await _timerNotificationPreferences.saveVibrationEnabled(enabled);
  }

  Future<void> setNotificationSound(TimerNotificationSound sound) async {
    notificationSound.value = sound;
    await _timerNotificationPreferences.saveSoundOption(sound);
  }

  void showThemeColorPicker(BuildContext context) {
    ThemeColorBottomSheet.show(context);
  }

  void showFontSizePicker(BuildContext context) {
    FontSizeBottomSheet.show(context);
  }

  void showNotificationSoundPicker(BuildContext context) {
    NotificationSoundBottomSheet.show(context);
  }

  void showAppInfo(BuildContext context) {
    AppInfoDialog.show(context);
  }

  void showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: '광고없는제과제빵실기',
      applicationIcon: Image.asset(
        AppInfoDialog.iconAsset,
        width: 72,
        height: 72,
        fit: BoxFit.contain,
      ),
    );
  }

  Future<void> openContactEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: contactEmail,
      query: _encodeQuery({'subject': '광고없는제과제빵실기 문의'}),
    );

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (launched || !context.mounted) return;

    AppSnackbar.show(
      context: context,
      title: '문의하기',
      message: '메일 앱을 열 수 없습니다. $contactEmail 로 직접 보내 주세요.',
    );
  }

  String? _encodeQuery(Map<String, String> params) {
    if (params.isEmpty) return null;
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  void showUserGuide() {
    unawaited(_showUserGuideInternal());
  }

  Future<void> _showUserGuideInternal() async {
    TutorialGuideLog.d(
      'showUserGuide: tap route=${Get.currentRoute} '
      'TutorialGuideService registered=${Get.isRegistered<TutorialGuideService>()} '
      'isFirstLaunch=${isFirstLaunch.value}',
    );

    if (isFirstLaunch.value) {
      isFirstLaunch.value = false;
      await _firstLaunchPreferences.saveIsFirstLaunch(false);
    }

    if (!Get.isRegistered<TutorialGuideService>()) {
      TutorialGuideLog.w('showUserGuide: TutorialGuideService 미등록 → 등록');
      Get.put(TutorialGuideService(), permanent: true);
    }

    await Get.find<TutorialGuideService>().startFromSettings();
  }

  Future<void> confirmAndResetAllProgressData(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('진행 데이터 초기화'),
        content: const Text(
          '저장된 실기 진행·타이머·재료 배율 데이터가 모두 삭제됩니다.\n'
          '이 작업은 되돌릴 수 없습니다. 계속할까요?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('초기화'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _progressDataResetService.resetAllProgressData();

    if (Get.isRegistered<ProgressListController>()) {
      await Get.find<ProgressListController>().loadSessions();
    }

    if (!context.mounted) return;

    AppSnackbar.show(
      context: context,
      title: '초기화 완료',
      message: '모든 진행 데이터가 삭제되었습니다.',
    );
  }
}
