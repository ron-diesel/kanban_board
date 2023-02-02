import 'package:flutter/material.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/core/widgets/custom_icon_button.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_decoration.dart';

class TaskLayout extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final Widget child;
  final int? taskId;
  final bool isExpand;

  const TaskLayout({
    required super.key,
    required this.child,
    this.isExpand = true,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    const iconKey = ValueKey('icon');
    return TaskDecoration(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 36,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${AppStrings.taskId}$taskId',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurface),
                      maxLines: 1,
                    ),
                  ),
                ),
                CustomIconButton(
                  onPressed: () => add(context, isExpand ? OnCollapse() : OnExpand()),
                  icon: AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      transitionBuilder: (child, anim) => RotationTransition(
                            turns: child.key == iconKey
                                ? Tween<double>(begin: 0.25, end: 0).animate(anim)
                                : Tween<double>(begin: 0, end: 0.25).animate(anim),
                            child: FadeTransition(opacity: anim, child: child),
                          ),
                      child: isExpand
                          ? const Icon(
                              Icons.close,
                            )
                          : const Icon(
                              Icons.expand_more,
                              key: iconKey,
                              color: AppColors.onSurface,
                            )),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
