import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [ScaffoldMessenger] 기반 공통 스낵바.
abstract final class AppSnackbar {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static ScaffoldMessengerState? _resolveMessenger([BuildContext? context]) {
    if (context != null) {
      return ScaffoldMessenger.maybeOf(context);
    }
    final fromKey = scaffoldMessengerKey.currentState;
    if (fromKey != null) return fromKey;
    final rootContext = Get.context;
    if (rootContext != null) {
      return ScaffoldMessenger.maybeOf(rootContext);
    }
    return null;
  }

  /// 기존 스낵바를 닫은 뒤 새 스낵바를 표시한다.
  static void show({
    required String title,
    required String message,
    BuildContext? context,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = _resolveMessenger(context);
    if (messenger == null) return;

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        content: _SnackbarContent(title: title, message: message),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: () {
                  messenger.hideCurrentSnackBar(
                    reason: SnackBarClosedReason.action,
                  );
                  onAction();
                },
              )
            : null,
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onInverseSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onInverseSurface,
          ),
        ),
      ],
    );
  }
}
