import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:baking_guide/app/routes/app_pages.dart';

void main() {
  testWidgets('Home shows recipe list from assets', (WidgetTester tester) async {
    Get.testMode = true;
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('밤식빵'), findsOneWidget);
    expect(find.text('소보로빵'), findsOneWidget);
    expect(find.text('3시간 40분'), findsOneWidget);
    expect(find.text('3시간'), findsOneWidget);

    Get.reset();
  });
}
