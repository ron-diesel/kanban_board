import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_state.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';

class TaskEditing extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final Task task;
  final GlobalKey taskKey;

  const TaskEditing(
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              autofocus: true,
              maxLines: null,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: AppStrings.editTaskHint,
              ),
              onChanged: (value) => add(
                context,
                OnInputUpdate(value),
              ),
              initialValue: task.desc,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => add(context, OnEditCancel()),
                child: const Text(AppStrings.cancel),
              ),
              BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                return TextButton(
                  onPressed: state.descInput.isEmpty ? null : () => add(context, OnSaveInput(task)),
                  child: const Text(AppStrings.save),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
