import 'package:flutter/cupertino.dart';
import 'package:songlib/navigator/main_navigator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../di/test_injectable.dart';
import '../view/seed.dart';
import '../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());

  testWidgets('Test main navigator widget login', (tester) async {
    seedLoginViewModel();
    seedGlobalViewModel();

    final key = GlobalKey<MainNavigatorState>();
    final sut = MainNavigator(key: key);
    final testWidget = await TestUtil.loadScreen(tester, sut);
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_login_screen_0_initial_screen');
    key.currentState!.goToLogin();
    await tester.pumpAndSettle();
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_login_screen_1');
//    The app should go to the previous screen. For some reason the screenshot has been taken successfully but the
//    key.currentState.goBack();
//    await tester.pumpAndSettle();
//    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_login_screen_2_go_back');
  });
}
