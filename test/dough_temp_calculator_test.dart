import 'package:flutter_test/flutter_test.dart';

import 'package:baking_guide/app/core/utils/dough_temp_calculator.dart';

void main() {
  test('recommendedWaterTempC matches reference UI example', () {
    expect(
      recommendedWaterTempC(
        targetDoughTemp: 27,
        baseTemp: 25,
        frictionHeat: 6,
      ),
      13,
    );
  });
}
