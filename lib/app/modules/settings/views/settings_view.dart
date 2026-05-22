import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

abstract final class _SettingsTileDimensions {
  static const double height = 56;
}

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
          const _SettingsSectionHeader(title: '일반 설정'),
          Obx(
            () => _SettingsSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: '다크 모드',
              value: controller.isDarkMode.value,
              onChanged: controller.setDarkMode,
            ),
          ),
          Obx(
            () => _SettingsNavigateTile(
              icon: Icons.wb_sunny_outlined,
              title: '앱 테마 색상',
              trailingText: controller.selectedSeedLabel,
              onTap: () => controller.showThemeColorPicker(context),
            ),
          ),
          const _SettingsSectionHeader(title: '실기 진행 설정'),
          Obx(
            () => _SettingsSwitchTile(
              icon: Icons.notifications_outlined,
              title: '타이머 알림',
              value: controller.timerNotificationsEnabled.value,
              onChanged: controller.setTimerNotificationsEnabled,
            ),
          ),
          Obx(
            () {
              final notificationsOn =
                  controller.timerNotificationsEnabled.value;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SettingsNavigateTile(
                    icon: Icons.volume_up_outlined,
                    title: '알림 소리',
                    trailingText: controller.notificationSoundLabel,
                    enabled: notificationsOn,
                    onTap: notificationsOn
                        ? () =>
                            controller.showNotificationSoundPicker(context)
                        : null,
                  ),
                  _SettingsSwitchTile(
                    icon: Icons.vibration_outlined,
                    title: '진동 알림',
                    value: controller.vibrationEnabled.value,
                    enabled: notificationsOn,
                    onChanged: notificationsOn
                        ? controller.setVibrationEnabled
                        : null,
                  ),
                ],
              );
            },
          ),
          const _SettingsSectionHeader(title: '화면/사용 설정'),
          Obx(
            () => _SettingsSwitchTile(
              icon: Icons.smartphone_outlined,
              title: '화면 자동 꺼짐 방지',
              value: controller.keepScreenOn.value,
              onChanged: controller.setKeepScreenOn,
            ),
          ),
          Obx(
            () {
              final label = controller.selectedFontSizeLabel;
              return _SettingsNavigateTile(
                icon: Icons.text_fields_outlined,
                title: '글자 크기',
                trailingText: label,
                onTap: () => controller.showFontSizePicker(context),
              );
            },
          ),
          Obx(
            () => _SettingsSwitchTile(
              icon: Icons.swipe_outlined,
              title: '좌우 스와이프로 단계 이동',
              value: controller.swipeStepNavigation.value,
              onChanged: controller.setSwipeStepNavigation,
            ),
          ),
          const _SettingsSectionHeader(title: '데이터/백업'),
          _SettingsNavigateTile(
            icon: Icons.delete_outline,
            title: '모든 진행 데이터 초기화',
            onTap: () => controller.confirmAndResetAllProgressData(context),
          ),
          const _SettingsSectionHeader(title: '기타'),
          _SettingsNavigateTile(
            icon: Icons.info_outline,
            title: '앱 정보',
            onTap: () => controller.showAppInfo(context),
          ),
          _SettingsNavigateTile(
            icon: Icons.description_outlined,
            title: '라이선스',
            onTap: () => controller.showLicenses(context),
          ),
          _SettingsNavigateTile(
            icon: Icons.help_outline,
            title: '도움말 / 사용 가이드',
            onTap: () {
              // TODO: 도움말 / 사용 가이드
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.star_outline,
            title: '평가하기',
            onTap: () {
              // TODO: 평가하기
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.mail_outline,
            title: '문의하기',
            onTap: () => controller.openContactEmail(context),
          ),
        ],
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  const _SettingsSectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _SettingsTileBase extends StatelessWidget {
  const _SettingsTileBase({
    required this.icon,
    required this.title,
    required this.trailing,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final Widget trailing;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabledColor = theme.colorScheme.onSurface.withValues(alpha: 0.38);
    final iconColor =
        enabled ? theme.colorScheme.primary : disabledColor;
    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      color: enabled ? null : disabledColor,
    );

    return Material(
      color: theme.colorScheme.surface,
      child: SizedBox(
        height: _SettingsTileDimensions.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 16),
              Expanded(child: Text(title, style: titleStyle)),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final disabledColor = theme.colorScheme.onSurface.withValues(alpha: 0.38);

    return Material(
      color: theme.colorScheme.surface,
      child: SizedBox(
        height: _SettingsTileDimensions.height,
        child: SwitchListTile(
          secondary: Icon(
            icon,
            color: enabled ? theme.colorScheme.primary : disabledColor,
            size: 24,
          ),
          title: Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: enabled ? null : disabledColor,
            ),
          ),
          value: value,
          onChanged: enabled ? onChanged : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}

class _SettingsNavigateTile extends StatelessWidget {
  const _SettingsNavigateTile({
    required this.icon,
    required this.title,
    this.trailingText,
    this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabledColor = theme.colorScheme.onSurface.withValues(alpha: 0.38);
    final trailingColor = enabled
        ? theme.colorScheme.onSurfaceVariant
        : disabledColor;

    return InkWell(
      onTap: enabled ? onTap : null,
      child: _SettingsTileBase(
        icon: icon,
        title: title,
        enabled: enabled,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(
                trailingText!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: trailingColor,
                ),
              ),
            if (trailingText != null) const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              color: trailingColor,
            ),
          ],
        ),
      ),
    );
  }
}
