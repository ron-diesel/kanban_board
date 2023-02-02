import 'package:flutter/material.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/core/widgets/text/body_text_large.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';

class TaskDeleting extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final Task task;
  final GlobalKey taskKey;

  const TaskDeleting(
    this.task, {
    required this.taskKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TaskLayout(
      key: taskKey,
      taskId: task.id,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: BodyTextLarge(AppStrings.deleteSure),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => add(context, OnDeleteCancel()),
                child: const Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () => add(context, OnDelete(task)),
                child: const Text(AppStrings.delete),
              )
            ],
          ),
        ],
      ),
    );
  }
}
