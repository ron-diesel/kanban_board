import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/core/widgets/utils.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_state.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_deleting.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_editing.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_expanded.dart';
import 'package:kanban_board/features/board/presentation/task/task_view_modes/task_preview.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final Task task;

  const TaskWidget(
    this.task, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TaskBloc, TaskState>(
        buildWhen: whenParamChanged((state) => state.viewMode),
        builder: (context, state) {
          return Provider<GlobalKey>(
            create: (_) => GlobalKey(),
            child: Builder(
              builder: (context) {
                final taskKey = context.read<GlobalKey>();
                switch (state.viewMode) {
                  case TaskViewMode.preview:
                    return TaskPreview(task, taskKey: taskKey);
                  case TaskViewMode.editing:
                    return TaskEditing(task, taskKey: taskKey);
                  case TaskViewMode.expanded:
                    return TaskExpanded(task, taskKey: taskKey);
                  case TaskViewMode.deleting:
                    return TaskDeleting(task, taskKey: taskKey);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
