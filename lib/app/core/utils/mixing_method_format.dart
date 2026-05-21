import '../../data/models/enums/mixing_method.dart';

String formatMixingMethod(MixingMethod method) {
  return switch (method) {
    MixingMethod.straight => '스트레이트법',
    MixingMethod.sponge => '스펀지법',
    MixingMethod.modifiedStraight => '변형 스트레이트법',
    MixingMethod.emergencyStraight => '비상 스트레이트법',
  };
}
