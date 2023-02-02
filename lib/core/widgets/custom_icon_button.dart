import 'package:flutter/material.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';

class CustomIconButton extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final VoidCallback? onPressed;
  final Widget icon;
  final Color? color;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
