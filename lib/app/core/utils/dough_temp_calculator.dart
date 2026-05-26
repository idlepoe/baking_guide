/// 반죽온도(DDT) 계산: 추천 물온도 = (목표 − 마찰열) * 3 − 기본온도 * 2
int recommendedWaterTempC({
  required num targetDoughTemp,
  required int baseTemp,
  required int frictionHeat,
}) {
  final water = (targetDoughTemp - frictionHeat) * 3 - baseTemp * 2;
  return water.round();
}

abstract final class DoughTempClothingPreset {
  static const assetPaths = [
    'assets/images/calculator/cloth1.png',
    'assets/images/calculator/cloth2.png',
    'assets/images/calculator/cloth3.png',
    'assets/images/calculator/cloth4.png',
  ];

  static const labels = ['반팔', '긴팔', '두꺼운 옷', '두꺼운 패딩'];
  static const seasons = ['여름', '봄 / 가을', '겨울', '한겨울'];
  static const baseTemps = [25, 20, 17, 15];

  static const minManualTemp = 15;
  static const maxManualTemp = 30;
}

abstract final class DoughTempFrictionPreset {
  static const assetPaths = [
    'assets/images/calculator/temp1.png',
    'assets/images/calculator/temp2.png',
    'assets/images/calculator/temp3.png',
  ];

  static const titles = ['가정용 믹서', '업소용 스파이럴', '수동 반죽'];
  static const subtitles = [
    '저~중속, +6°C',
    '중~고속, +10°C',
    '손반죽, +2°C',
  ];
  static const heatC = [6, 10, 2];
}
