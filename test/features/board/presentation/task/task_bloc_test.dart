import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/di/test_di_module.dart';
import '../../../../core/di/test_di_module.mocks.dart';

final _lastColumnUpdate = DateTime(0);
final _task = Task(columnId: 0, lastColumnUpdate: _lastColumnUpdate);
const _input = "input";

void main() {
  group('TaskBloc event handling', () {
    TestsDiModule().init();
    final MockUpdateTaskUseCase updateTask = getIt();
    final MockDeleteTaskUseCase deleteTask = getIt();

    TaskBloc build() => TaskBloc(updateTask: updateTask, deleteTask: deleteTask);

    setUpAll(() {
      when(deleteTask(any)).thenAnswer((_) => ResultSuccess(0));
      when(updateTask(any)).thenAnswer((_) => ResultSuccess(true));
    });

    blocTest(
      'emits OnExpand',
      build: build,
      act: (bloc) => bloc.add(OnExpand()),
      expect: () => [const TaskState(viewMode: TaskViewMode.expanded)],
    );

    blocTest(
      'emits OnCollapse',
      build: build,
      act: (bloc) => bloc.add(OnCollapse()),
      expect: () => [const TaskState(viewMode: TaskViewMode.preview)],
    );

    blocTest(
      'emits OnEditStart',
      build: build,
      act: (bloc) => bloc.add(OnEditStart(_task)),
      expect: () => [const TaskState(viewMode: TaskViewMode.editing, descInput: AppStrings.newTask)],
    );

    blocTest(
      'emits OnEditCancel',
      build: build,
      act: (bloc) => bloc.add(OnEditCancel()),
      expect: () => [const TaskState(viewMode: TaskViewMode.expanded)],
    );

    blocTest(
      'emits OnDeleteStart',
      build: build,
      act: (bloc) => bloc.add(OnDeleteStart()),
      expect: () => [const TaskState(viewMode: TaskViewMode.deleting)],
    );

    blocTest(
      'emits OnDeleteCancel',
      build: build,
      act: (bloc) => bloc.add(OnDeleteCancel()),
      expect: () => [const TaskState(viewMode: TaskViewMode.expanded)],
    );

    blocTest(
      'emits OnDelete',
      build: build,
      act: (bloc) => bloc.add(OnDelete(_task)),
      verify: (_) => verify(deleteTask(_task)).called(1),
    );

    blocTest(
      'emits OnTimerSwitch',
      build: build,
      act: (bloc) => bloc.add(OnTimerSwitch(_task)),
      verify: (_) => verify(updateTask(any)).called(1),
    );

    blocTest(
      'emits OnSaveInput',
      build: build,
      skip: TestsDiModule.skipHandle,
      act: (bloc) => bloc.add(OnSaveInput(_task)),
      expect: () => [const TaskState(viewMode: TaskViewMode.preview)],
      verify: (_) => verify(updateTask(any)).called(1),
    );

    blocTest(
      'emits OnInputUpdate',
      build: build,
      act: (bloc) => bloc.add(OnInputUpdate(_input)),
      expect: () => [const TaskState(descInput: _input)],
    );
  });
}
