import 'package:flutter/material.dart';

import '../../../core/utils/dough_temp_calculator.dart';
import '../../../data/models/calculator_config.dart';
import '../controllers/progress_detail_controller.dart';

abstract final class _SheetColors {
  static const targetBackground = Color(0xFFFFF3E0);
  static const targetAccent = Color(0xFFE65100);
  static const resultBackground = Color(0xFFE3F2FD);
  static const resultAccent = Color(0xFF1565C0);
  static const tipBackground = Color(0xFFE8F4FD);
}

class DoughTempCalculatorBottomSheet extends StatefulWidget {
  const DoughTempCalculatorBottomSheet({
    super.key,
    required this.config,
  });

  final CalculatorConfig config;

  static void show(
    BuildContext context,
    ProgressDetailController controller,
  ) {
    final config = controller.currentDoughTempCalculator;
    if (config == null) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => DoughTempCalculatorBottomSheet(config: config),
    );
  }

  @override
  State<DoughTempCalculatorBottomSheet> createState() =>
      _DoughTempCalculatorBottomSheetState();
}

class _DoughTempCalculatorBottomSheetState
    extends State<DoughTempCalculatorBottomSheet> {
  int _clothingIndex = 0;
  int _frictionIndex = 0;
  late int _manualBaseTemp;

  num get _targetTemp => widget.config.params.target ?? 27;

  int get _baseTemp => _manualBaseTemp;

  int get _frictionHeat => DoughTempFrictionPreset.heatC[_frictionIndex];

  int get _recommendedWater => recommendedWaterTempC(
        targetDoughTemp: _targetTemp,
        baseTemp: _baseTemp,
        frictionHeat: _frictionHeat,
      );

  @override
  void initState() {
    super.initState();
    _manualBaseTemp = DoughTempClothingPreset.baseTemps.first;
  }

  void _selectClothing(int index) {
    setState(() {
      _clothingIndex = index;
      _manualBaseTemp = DoughTempClothingPreset.baseTemps[index];
    });
  }

  void _adjustBaseTemp(int delta) {
    setState(() {
      _manualBaseTemp = (_manualBaseTemp + delta).clamp(
        DoughTempClothingPreset.minManualTemp,
        DoughTempClothingPreset.maxManualTemp,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;
    final target = _targetTemp.round();

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      '반죽온도 계산기',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showInfoDialog(context),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TargetCard(targetTemp: target),
                    const SizedBox(height: 16),
                    _SectionCard(
                      icon: Icons.thermostat_outlined,
                      title: '기본 온도 설정',
                      subtitle:
                          '실온과 분온이 같다고 가정합니다. 옷차림으로 대략적인 실온을 선택하세요.',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '옷차림으로 선택하기',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _ClothingGrid(
                            selectedIndex: _clothingIndex,
                            onSelect: _selectClothing,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '직접 온도 조절하기',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _ManualTempStepper(
                            value: _manualBaseTemp,
                            onDecrement: () => _adjustBaseTemp(-1),
                            onIncrement: () => _adjustBaseTemp(1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '권장 범위: ${DoughTempClothingPreset.minManualTemp}°C ~ '
                            '${DoughTempClothingPreset.maxManualTemp}°C',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
                      icon: Icons.whatshot_outlined,
                      title: '마찰열 설정',
                      subtitle: '믹서 종류와 반죽 방식에 따라 달라집니다.',
                      child: Column(
                        children: [
                          for (var i = 0; i < 3; i++) ...[
                            if (i > 0) const SizedBox(height: 8),
                            _FrictionOptionTile(
                              index: i,
                              selected: _frictionIndex == i,
                              onTap: () => setState(() => _frictionIndex = i),
                            ),
                          ],
                          const SizedBox(height: 8),
                          Text(
                            '믹서 종류, 속도, 반죽 시간에 따라 실제 마찰열은 달라질 수 있습니다.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ResultCard(waterTemp: _recommendedWater),
                    const SizedBox(height: 16),
                    _TipCard(targetTemp: target),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('반죽온도 계산기'),
        content: const Text(
          '추천 물온도 = (목표 반죽온도 − 마찰열) × 3 − 기본온도 × 2\n\n'
          '기본온도는 실온·분온을 같다고 보고 설정합니다. '
          '계산값은 참고용이며, 반죽 후 실제 반죽온도를 확인하세요.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({required this.targetTemp});

  final int targetTemp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _SheetColors.targetBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _SheetColors.targetAccent.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.track_changes, color: _SheetColors.targetAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '목표 반죽온도',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _SheetColors.targetAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$targetTemp°C',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _SheetColors.targetAccent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '최종 반죽 온도를 $targetTemp°C로 맞추기 위한 추천 물온도 계산기입니다.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.waterTemp});

  final int waterTemp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _SheetColors.resultBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _SheetColors.resultAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.water_drop_outlined, color: _SheetColors.resultAccent, size: 32),
          const SizedBox(height: 8),
          Text(
            '추천 물온도',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: _SheetColors.resultAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$waterTemp°C',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _SheetColors.resultAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '계절과 마찰열을 고려한 추천 물온도입니다.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.targetTemp});

  final int targetTemp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _SheetColors.tipBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TIP',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '계산된 물온도는 참고용입니다. 반죽 후 실제 반죽온도를 확인하고, '
                  '목표($targetTemp°C ±1°C)에 맞게 조절하세요.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.help_outline, size: 20, color: Colors.grey.shade500),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _ClothingGrid extends StatelessWidget {
  const _ClothingGrid({
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        for (var i = 0; i < 4; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _ClothingCard(
              imagePath: DoughTempClothingPreset.assetPaths[i],
              label: DoughTempClothingPreset.labels[i],
              season: DoughTempClothingPreset.seasons[i],
              selected: selectedIndex == i,
              onTap: () => onSelect(i),
              theme: theme,
            ),
          ),
        ],
      ],
    );
  }
}

class _ClothingCard extends StatelessWidget {
  const _ClothingCard({
    required this.imagePath,
    required this.label,
    required this.season,
    required this.selected,
    required this.onTap,
    required this.theme,
  });

  final String imagePath;
  final String label;
  final String season;
  final bool selected;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected ? _SheetColors.targetAccent : Colors.grey.shade300;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: selected ? 2 : 1),
          ),
          child: Column(
            children: [
              Image.asset(imagePath, height: 48, fit: BoxFit.contain),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    maxLines: 1,
                    softWrap: false,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text(
                season,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrictionOptionTile extends StatelessWidget {
  const _FrictionOptionTile({
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor =
        selected ? _SheetColors.targetAccent : Colors.grey.shade300;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: selected ? 2 : 1),
          ),
          child: Row(
            children: [
              Image.asset(
                DoughTempFrictionPreset.assetPaths[index],
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DoughTempFrictionPreset.titles[index],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DoughTempFrictionPreset.subtitles[index],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ManualTempStepper extends StatelessWidget {
  const _ManualTempStepper({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final atMin = value <= DoughTempClothingPreset.minManualTemp;
    final atMax = value >= DoughTempClothingPreset.maxManualTemp;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: atMin ? null : onDecrement,
            icon: const Icon(Icons.remove),
          ),
          Text(
            '$value°C',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: atMax ? null : onIncrement,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
