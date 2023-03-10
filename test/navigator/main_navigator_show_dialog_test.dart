import 'package:flutter/cupertino.dart';
import 'package:songlib/navigator/main_navigator.dart';
import 'package:songlib/view/settings/dialogs/select_language_dialog.dart';
import 'package:songlib/viewmodel/global/global_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../di/test_injectable.dart';
import '../view/seed.dart';
import '../util/test_util.dart';

void main() {
  late GlobalViewModel globalViewModel;

  setUp(() async {
    await initTestInjectable();
    globalViewModel = GetIt.I();
  });

  testWidgets('Test main navigator widget show dialog', (tester) async {
    seedGlobalViewModel();
    when(globalViewModel.isLanguageSelected('en')).thenAnswer((_) => true);
    when(globalViewModel.isLanguageSelected('nl')).thenAnswer((_) => false);
    when(globalViewModel.isLanguageSelected(null)).thenAnswer((_) => false);

    final key = GlobalKey<MainNavigatorState>();
    final sut = MainNavigator(key: key);
    final testWidget = await TestUtil.loadScreen(tester, sut);
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_show_dialog_0_initial_screen');
    key.currentState!.showCustomDialog<void>(
      builder: (context) => SelectLanguageDialog(
        goBack: () {},
      ),
    );
    await tester.pumpAndSettle();
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_show_dialog_1');
    key.currentState!.closeDialog();
    await tester.pumpAndSettle();
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_show_dialog_2_go_back');
  });
}
