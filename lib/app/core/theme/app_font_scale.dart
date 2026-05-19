/// 앱 글자 크기 프리셋.
enum AppFontScale {
  small,
  medium,
  large;

  String get id => name;

  String get label => switch (this) {
        AppFontScale.small => '작게',
        AppFontScale.medium => '중간',
        AppFontScale.large => '크게',
      };

  double get fontSizeFactor => switch (this) {
        AppFontScale.small => 0.9,
        AppFontScale.medium => 1.0,
        AppFontScale.large => 1.15,
      };

  static AppFontScale fromId(String? id) {
    return AppFontScale.values.firstWhere(
      (scale) => scale.id == id,
      orElse: () => AppFontScale.medium,
    );
  }
}
