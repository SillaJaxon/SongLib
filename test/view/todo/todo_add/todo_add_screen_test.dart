import 'package:songlib/view/todo/todo_add/todo_add_screen.dart';
import 'package:songlib/util/keys.dart';
import 'package:songlib/viewmodel/todo/todo_add/todo_add_viewmodel.dart';
import 'package:songlib/widget/general/styled/songlib_button.dart';
import 'package:songlib/widget/general/styled/songlib_input_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../../di/injectable_test.mocks.dart';
import '../../../di/test_injectable.dart';
import '../../../util/test_extensions.dart';
import '../../../util/test_util.dart';
import '../../seed.dart';

void main() {
  late TodoAddViewModel todoAddViewModel;

  setUp(() async {
    await initTestInjectable();
    todoAddViewModel = GetIt.I();
    seedTodoAddViewModel();
    seedGlobalViewModel();
  });

  testWidgets('Test todo add screen initial state', (tester) async {
    const sut = TodoAddScreen();
    final testWidget = await TestUtil.loadScreen(tester, sut);

    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'todo_add_screen_inital_state');
    verifyTodoAddViewModel();
    verifyGlobalViewModel();
  });

  testWidgets('Test todo add screen button enabled', (tester) async {
    when(todoAddViewModel.isSaveEnabled).thenReturn(true);
    const sut = TodoAddScreen();
    final testWidget = await TestUtil.loadScreen(tester, sut);

    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'todo_add_screen_enabled');
    verifyTodoAddViewModel();
    verifyGlobalViewModel();
  });

  group('Actions', () {
    testWidgets('Test todo add screen button enabled disabled on back clicked', (tester) async {
      const sut = TodoAddScreen();
      await TestUtil.loadScreen(tester, sut);

      final finder = find.byKey(Keys.backButton);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      verify(todoAddViewModel.onBackClicked()).calledOnce();
      verifyTodoAddViewModel();
      verifyGlobalViewModel();
    });

    testWidgets('Test todo add screen button disabled on save clicked', (tester) async {
      when(todoAddViewModel.isSaveEnabled).thenReturn(true);
      const sut = TodoAddScreen();
      await TestUtil.loadScreen(tester, sut);

      final finder = find.byType(KiolezoFlutterButton);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      verify(todoAddViewModel.onSaveClicked()).calledOnce();
      verifyTodoAddViewModel();
      verifyGlobalViewModel();
    });

    testWidgets('Test todo add screen button disabled on back clicked', (tester) async {
      const sut = TodoAddScreen();
      await TestUtil.loadScreen(tester, sut);

      final finder = find.byType(KiolezoFlutterButton);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      verifyTodoAddViewModel();
      verifyGlobalViewModel();
    });

    testWidgets('Test todo add screen should have an input field', (tester) async {
      const sut = TodoAddScreen();
      await TestUtil.loadScreen(tester, sut);

      final finder = find.byType(KiolezoFlutterInputField);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      await tester.enterText(finder, 'test');

      verify(todoAddViewModel.onTodoChanged('test')).calledOnce();
      verifyTodoAddViewModel();
      verifyGlobalViewModel();
    });
  });
}

void verifyTodoAddViewModel() {
  final todoAddViewModel = GetIt.I.resolveAs<TodoAddViewModel, MockTodoAddViewModel>();
  verify(todoAddViewModel.isSaveEnabled);
  verify(todoAddViewModel.init(any)).calledOnce();
}
