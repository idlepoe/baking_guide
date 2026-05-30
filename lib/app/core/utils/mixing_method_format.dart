import '../../data/models/enums/mixing_method.dart';

String formatMixingMethod(MixingMethod method) {
  return switch (method) {
    MixingMethod.straight => '스트레이트법',
    MixingMethod.sponge => '스펀지법',
    MixingMethod.modifiedStraight => '변형 스트레이트법',
    MixingMethod.emergencyStraight => '비상 스트레이트법',
    MixingMethod.cream => '크림법',
    MixingMethod.separatedEgg => '별립법',
    MixingMethod.chiffon => '시폰법',
    MixingMethod.meringue => '머랭법',
    MixingMethod.oneStage => '1단계법',
    MixingMethod.choux => '슈반죽법',
    MixingMethod.blending => '블렌딩법',
  };
}
