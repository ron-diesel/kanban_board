import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_bloc.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_state.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';
import 'package:kanban_board/features/board/presentation/task/task_time_widget.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_expanded.dart';
import 'package:mockito/mockito.dart';

import '../../../../../core/di/test_di_module.dart';
import '../../../../../core/di/test_di_module.mocks.dart';

final _task = Task(columnId: 0, lastColumnUpdate: DateTime(2222, 1, 22, 22, 22));
const _column = BoardColumn(name: AppStrings.todoColumn, id: 0);
const _columnState = ColumnState(column: _column);

void main() {
  group('TaskExpanded', () {
    TestsDiModule().init();
    late MockColumnBloc columnBloc;
    late MockTaskBloc bloc;
    Widget build() => MaterialApp(
          home: BlocProvider<ColumnBloc>(
            create: (_) {
              columnBloc = getIt<MockColumnBloc>();
              when(columnBloc.state).thenReturn(_columnState);
              return columnBloc;
            },
            child: BlocProvider<TaskBloc>(
              create: (_) {
                bloc = getIt<MockTaskBloc>();
                return bloc;
              },
              child: TaskExpanded(_task, taskKey: GlobalKey()),
            ),
          ),
        );

    testWidgets('displays the all task information', (tester) async {
      await tester.pumpWidget(build());
      expect(find.text(_task.desc), findsOneWidget);
      expect(find.text('${_column.name} ${AppStrings.from} '), findsOneWidget);
      expect(find.text('22:22 22 Jan 2222'), findsOneWidget);
      expect(find.byType(TaskTimeWidget), findsOneWidget);
      expect(find.byType(TaskLayout), findsOneWidget);
    });

    testWidgets('Test on press of edit button', (tester) async {
      await tester.pumpWidget(build());
      final editButton = find.byIcon(Icons.edit);
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      verify(bloc.add(OnEditStart(_task))).called(1);
    });

    testWidgets('Test on press of delete button', (tester) async {
      await tester.pumpWidget(build());
      final deleteButton = find.byIcon(Icons.delete_outlined);
      expect(deleteButton, findsOneWidget);
      await tester.tap(deleteButton);
      verify(bloc.add(OnDeleteStart())).called(1);
    });

    testWidgets('Test of time tracker switch', (tester) async {
      await tester.pumpWidget(build());
      final switcher = find.byType(Switch);
      expect(switcher, findsOneWidget);
      await tester.tap(switcher);
      await tester.pumpAndSettle();
      await tester.tap(switcher);
      verify(bloc.add(OnTimerSwitch(_task))).called(2);
    });
  });
}
