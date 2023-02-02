import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';
import 'package:kanban_board/features/board/presentation/task/task_time_widget.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_preview.dart';
import 'package:mockito/mockito.dart';

import '../../../../../core/di/test_di_module.dart';
import '../../../../../core/di/test_di_module.mocks.dart';

final _task = Task(columnId: 0, lastColumnUpdate: DateTime(0));

void main() {
  group('TaskPreview', () {
    TestsDiModule().init();
    late MockTaskBloc bloc;
    Widget build() => MaterialApp(
          home: BlocProvider<TaskBloc>(
            create: (_) {
              bloc = getIt<MockTaskBloc>();
              return bloc;
            },
            child: TaskPreview(_task, taskKey: GlobalKey()),
          ),
        );

    testWidgets('displays the all task information', (tester) async {
      await tester.pumpWidget(build());
      expect(find.text(_task.desc), findsOneWidget);
      expect(find.byType(TaskTimeWidget), findsOneWidget);
      expect(find.byType(TaskLayout), findsOneWidget);
    });

    testWidgets('Test on tap', (tester) async {
      await tester.pumpWidget(build());
      final layout = find.byType(TaskLayout);
      expect(layout, findsOneWidget);
      await tester.tap(layout);
      verify(bloc.add(OnExpand())).called(1);
    });

    testWidgets('Test on drag and drop', (tester) async {
      await tester.pumpWidget(build());
      final layout = find.byType(TaskLayout);
      final opacity = find.byType(Opacity);
      expect(layout, findsOneWidget);
      expect(opacity, findsNothing);
      await tester.longPress(layout);
      expect(opacity, findsOneWidget);
      await tester.pump();
      expect(opacity, findsNothing);
    });
  });
}
