import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

abstract final class _SettingsColors {
  static const iconTint = Color(0xFF7E57C2);
}

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
      ),
      body: ListView(
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
          _SettingsNavigateTile(
            icon: Icons.wb_sunny_outlined,
            title: '앱 테마 색상',
            onTap: () {
              // TODO: 앱 테마 색상 설정
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.language_outlined,
            title: '언어',
            trailingText: '한국어',
            onTap: () {
              // TODO: 언어 설정
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.straighten_outlined,
            title: '단위 설정',
            trailingText: 'g, °C',
            onTap: () {
              // TODO: 단위 설정
            },
          ),
          const _SettingsSectionHeader(title: '실기 진행 설정'),
          _SettingsNavigateTile(
            icon: Icons.timer_outlined,
            title: '타이머 기본 시간 설정',
            onTap: () {
              // TODO: 타이머 기본 시간 설정
            },
          ),
          _SettingsSwitchTile(
            icon: Icons.notifications_outlined,
            title: '타이머 알림',
            value: true,
            onChanged: (_) {
              // TODO: 타이머 알림
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.volume_up_outlined,
            title: '알림 소리',
            trailingText: '기본',
            onTap: () {
              // TODO: 알림 소리 설정
            },
          ),
          _SettingsSwitchTile(
            icon: Icons.vibration_outlined,
            title: '진동 알림',
            value: true,
            onChanged: (_) {
              // TODO: 진동 알림
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.pause_circle_outline,
            title: '발효 단계 자동 일시정지',
            trailingText: '화면 이탈 시',
            onTap: () {
              // TODO: 발효 단계 자동 일시정지
            },
          ),
          const _SettingsSectionHeader(title: '화면/사용 설정'),
          _SettingsNavigateTile(
            icon: Icons.smartphone_outlined,
            title: '화면 자동 꺼짐 방지',
            trailingText: '사용중',
            onTap: () {
              // TODO: 화면 자동 꺼짐 방지
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.text_fields_outlined,
            title: '글자 크기',
            trailingText: '중간',
            onTap: () {
              // TODO: 글자 크기 설정
            },
          ),
          _SettingsSwitchTile(
            icon: Icons.swipe_outlined,
            title: '좌우 스와이프로 단계 이동',
            value: true,
            onChanged: (_) {
              // TODO: 좌우 스와이프로 단계 이동
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.view_module_outlined,
            title: '단계 목록 스타일',
            trailingText: '카드형',
            onTap: () {
              // TODO: 단계 목록 스타일
            },
          ),
          const _SettingsSectionHeader(title: '데이터/백업'),
          _SettingsNavigateTile(
            icon: Icons.cloud_upload_outlined,
            title: '진행 데이터 백업',
            onTap: () {
              // TODO: 진행 데이터 백업
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.cloud_download_outlined,
            title: '백업 데이터 복원',
            onTap: () {
              // TODO: 백업 데이터 복원
            },
          ),
          _SettingsNavigateTile(
            icon: Icons.delete_outline,
            title: '모든 진행 데이터 초기화',
            onTap: () {
              // TODO: 모든 진행 데이터 초기화
            },
          ),
          const _SettingsSectionHeader(title: '기타'),
          _SettingsNavigateTile(
            icon: Icons.info_outline,
            title: '앱 정보',
            onTap: () {
              // TODO: 앱 정보
            },
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
            onTap: () {
              // TODO: 문의하기
            },
          ),
        ],
      ),
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
  });

  final IconData icon;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: _SettingsColors.iconTint, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            trailing,
          ],
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
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return _SettingsTileBase(
      icon: icon,
      title: title,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: _SettingsColors.iconTint,
      ),
    );
  }
}

class _SettingsNavigateTile extends StatelessWidget {
  const _SettingsNavigateTile({
    required this.icon,
    required this.title,
    this.trailingText,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: _SettingsTileBase(
        icon: icon,
        title: title,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(
                trailingText!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            if (trailingText != null) const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
