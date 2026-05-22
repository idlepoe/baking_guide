import 'package:flutter/material.dart';

/// 시드 색상 프리셋.
class AppSeedColor {
  const AppSeedColor({
    required this.id,
    required this.label,
    required this.value,
  });

  final String id;
  final String label;
  final Color value;
}

abstract final class AppSeedColors {
  static const defaultSeed = Color(0xFF205FA8);

  static const presets = <AppSeedColor>[
    AppSeedColor(id: 'blue', label: '블루', value: Color(0xFF205FA8)),
    AppSeedColor(id: 'amber', label: '앰버', value: Color(0xFFFFC107)),
    AppSeedColor(id: 'indigo', label: '인디고', value: Color(0xFF353D94)),
    AppSeedColor(id: 'purple', label: '퍼플', value: Color(0xFF6750A4)),
    AppSeedColor(id: 'green', label: '그린', value: Color(0xFF366A1D)),
    AppSeedColor(id: 'teal', label: '틸', value: Color(0xFF006A6A)),
    AppSeedColor(id: 'orange', label: '오렌지', value: Color(0xFFE65100)),
    AppSeedColor(id: 'red', label: '레드', value: Color(0xFFBA1A1A)),
    AppSeedColor(id: 'pink', label: '핑크', value: Color(0xFF984061)),
    AppSeedColor(id: 'brown', label: '브라운', value: Color(0xFF6D4C41)),
  ];

  static AppSeedColor labelFor(Color color) {
    for (final preset in presets) {
      if (preset.value.toARGB32() == color.toARGB32()) {
        return preset;
      }
    }
    return const AppSeedColor(id: 'custom', label: '사용자', value: defaultSeed);
  }
}
