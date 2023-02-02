import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_bloc.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_event.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/di/test_di_module.dart';
import '../../../../core/di/test_di_module.mocks.dart';

final _lastColumnUpdate = DateTime(0);
final _task = Task(columnId: 0, lastColumnUpdate: _lastColumnUpdate);
final _tasks = [_task];
const _column = BoardColumn(name: "column", id: 0);

void main() {
  group('ColumnBloc event handling', () {
    TestsDiModule().init();
    final MockUpdateTaskUseCase updateTask = getIt();
    final MockWatchTasksForUseCase watchTasks = getIt();
    final MockAddTaskUseCase addTask = getIt();
    final MockShareColumnUseCase shareColumn = getIt();

    ColumnBloc build() => ColumnBloc(
          column: _column,
          watchTasks: watchTasks,
          addTask: addTask,
          updateTask: updateTask,
          shareColumn: shareColumn,
        );

    setUpAll(() {
      when(updateTask(any)).thenAnswer((_) => ResultSuccess(true));
      when(watchTasks(any)).thenAnswer((_) => ResultSuccess(Stream.value(_tasks)));
      when(addTask(any)).thenAnswer((_) => ResultSuccess(0));
      when(shareColumn(any)).thenAnswer((_) => ResultSuccess(null));
    });

    blocTest(
      'OnInit',
      build: build,
      skip: TestsDiModule.skipHandle,
      expect: () => [
        const ColumnState(column: _column),
        ColumnState(tasks: _tasks, column: _column),
      ],
      verify: (_) => verify(watchTasks(_column)).called(1),
    );

    blocTest(
      'emits OnAddTaskClick',
      build: build,
      act: (bloc) => bloc.add(OnAddTaskClick()),
      verify: (_) => verify(addTask(any)).called(1),
    );

    blocTest(
      'emits OnShareClick',
      build: build,
      act: (bloc) => bloc.add(OnShareClick()),
      verify: (_) => verify(shareColumn(_column)).called(1),
    );

    blocTest(
      'emits OnTasksUpdate',
      build: build,
      skip: TestsDiModule.skipHandle * 2,
      act: (bloc) => bloc.add(OnTasksUpdate(_tasks)),
      expect: () => [ColumnState(tasks: _tasks, column: _column)],
    );

    blocTest('emits OnTaskDrop',
        build: build,
        act: (bloc) => bloc.add(OnTaskDrop(_task.copyWith(columnId: 2))),
        verify: (_) {
          final verification = verify(updateTask(captureAny));
          expect(verification.captured.single.columnId, _column.id);
          verification.called(1);
        });
  });
}
