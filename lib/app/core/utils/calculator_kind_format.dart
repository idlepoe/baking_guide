import 'package:flutter/material.dart';

import '../../data/models/enums/calculator_kind.dart';

String calculatorFabLabel(CalculatorKind type) {
  return switch (type) {
    CalculatorKind.doughTemp => '반죽온도',
    CalculatorKind.divisionWeight => '분할 계량',
    CalculatorKind.bakerPercentage => '배합 비율',
    CalculatorKind.specificGravity => '비중',
  };
}

IconData calculatorFabIcon(CalculatorKind type) {
  return switch (type) {
    CalculatorKind.doughTemp => Icons.water_drop_outlined,
    CalculatorKind.divisionWeight => Icons.scale_outlined,
    CalculatorKind.bakerPercentage => Icons.percent_outlined,
    CalculatorKind.specificGravity => Icons.science_outlined,
  };
}
