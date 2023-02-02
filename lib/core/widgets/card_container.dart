import 'package:flutter/material.dart';
import 'package:kanban_board/core/app_colors.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double radius;
  final double elevation;

  const CardContainer({
    required this.child,
    this.radius = 8,
    this.elevation = 4,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(radius),
      color: color ?? AppColors.surface,
      child: child,
    );
  }
}
