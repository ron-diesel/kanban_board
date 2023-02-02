import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/core/app_extensions.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/core/widgets/custom_icon_button.dart';
import 'package:kanban_board/core/widgets/text/body_text_large.dart';
import 'package:kanban_board/core/widgets/text/body_text_medium.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';
import 'package:kanban_board/features/board/presentation/task/task_time_widget.dart';

const _dateFormat = 'HH:mm dd MMM yyyy';

class TaskExpanded extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final Task task;
  final GlobalKey taskKey;

  const TaskExpanded(
    this.task, {
    required this.taskKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final column = context.read<ColumnBloc>().state.column;
    return TaskLayout(
      key: taskKey,
      taskId: task.id,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BodyTextLarge(
              task.desc,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                BodyTextMedium(
                  '${column.name} ${AppStrings.from} ',
                  color: AppColors.onSurface,
                ),
                BodyTextLarge(task.lastColumnUpdate.format(_dateFormat)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TaskTimeWidget(
                  task,
                  key: ValueKey(task.isTimerLaunched),
                ),
              ),
              Switch(
                value: task.isTimerLaunched,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (_) => add(context, OnTimerSwitch(task)),
              ),
              const Spacer(),
              CustomIconButton(
                onPressed: () => add(context, OnDeleteStart()),
                icon: const Icon(
                  Icons.delete_outlined,
                  color: AppColors.error,
                ),
              ),
              CustomIconButton(
                onPressed: () => add(context, OnEditStart(task)),
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
