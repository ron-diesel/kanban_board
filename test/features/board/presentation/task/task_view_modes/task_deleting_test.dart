import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_deleting.dart';
import 'package:mockito/mockito.dart';

import '../../../../../core/di/test_di_module.dart';
import '../../../../../core/di/test_di_module.mocks.dart';

final _task = Task(columnId: 0, lastColumnUpdate: DateTime(0));

void main() {
  group('TaskDeleting', () {
    TestsDiModule().init();
    late MockTaskBloc bloc;
    Widget build() => MaterialApp(
          home: BlocProvider<TaskBloc>(
            create: (_) {
              bloc = getIt<MockTaskBloc>();
              return bloc;
            },
            child: TaskDeleting(_task, taskKey: GlobalKey()),
          ),
        );

    testWidgets('displays the delete confirmation', (tester) async {
      await tester.pumpWidget(build());
      expect(find.text(AppStrings.deleteSure), findsOneWidget);
      expect(find.byType(TaskLayout), findsOneWidget);
    });

    testWidgets('Test on press of cancel button', (tester) async {
      await tester.pumpWidget(build());
      final cancelButton = find.text(AppStrings.cancel);
      expect(cancelButton, findsOneWidget);
      await tester.tap(cancelButton);
      verify(bloc.add(OnDeleteCancel())).called(1);
    });

    testWidgets('Test on press of delete button', (tester) async {
      await tester.pumpWidget(build());
      final deleteButton = find.text(AppStrings.delete);
      expect(deleteButton, findsOneWidget);
      await tester.tap(deleteButton);
      verify(bloc.add(OnDelete(_task))).called(1);
    });
  });
}
