import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_state.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_editing.dart';
import 'package:mockito/mockito.dart';

import '../../../../../core/di/test_di_module.dart';
import '../../../../../core/di/test_di_module.mocks.dart';

final _task = Task(columnId: 0, lastColumnUpdate: DateTime(0));
const _input = 'input';
const _state = TaskState();

void main() {
  group('TaskEditing', () {
    TestsDiModule().init();
    late MockTaskBloc bloc;
    Widget build(TaskState state) => MaterialApp(
          home: BlocProvider<TaskBloc>(
            create: (_) {
              bloc = getIt<MockTaskBloc>();
              when(bloc.state).thenReturn(state);
              return bloc;
            },
            child: TaskEditing(_task, taskKey: GlobalKey()),
          ),
        );

    testWidgets('displays the all task information', (tester) async {
      await tester.pumpWidget(build(_state));
      expect(find.text(_task.desc), findsOneWidget);
      expect(find.byType(TaskLayout), findsOneWidget);
    });

    testWidgets('Test on press of cancel button', (tester) async {
      await tester.pumpWidget(build(_state));
      final cancelButton = find.text(AppStrings.cancel);
      expect(cancelButton, findsOneWidget);
      await tester.tap(cancelButton);
      verify(bloc.add(OnEditCancel())).called(1);
    });

    testWidgets('Test on press of save button when input not empty', (tester) async {
      await tester.pumpWidget(build(_state.copyWith(descInput: _input)));
      final saveButton = find.text(AppStrings.save);
      expect(saveButton, findsOneWidget);
      await tester.tap(saveButton);
      verify(bloc.add(OnSaveInput(_task))).called(1);
    });

    testWidgets('Test on press of save button when input empty', (tester) async {
      await tester.pumpWidget(build(_state));
      final saveButton = find.text(AppStrings.save);
      expect(saveButton, findsOneWidget);
      await tester.tap(saveButton);
      verifyNever(bloc.add(OnSaveInput(_task)));
    });

    testWidgets('value changes on user input', (WidgetTester tester) async {

      final initialValue = _task.desc;
      const newValue = 'new value of input';
      await tester.pumpWidget(build(_state.copyWith(descInput: initialValue)));

      final textField = find.byType(TextField);
      final TextField textFieldWidget = tester.firstWidget(textField);
      expect(textFieldWidget.controller?.text, initialValue);

      await tester.enterText(textField, newValue);
      await tester.pump();

      expect(textFieldWidget.controller?.text, newValue);
      verify(bloc.add(OnInputUpdate(newValue))).called(1);
    });

  });
}

