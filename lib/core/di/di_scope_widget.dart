import 'package:flutter/material.dart';
import 'package:kanban_board/core/di/base_di_module.dart';

class DIScopeWidget extends StatefulWidget {
  final Widget child;
  final BaseDIModule module;

  const DIScopeWidget({
    required this.child,
    required this.module,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DIScopeWidgetState();
}

class _DIScopeWidgetState extends State<DIScopeWidget> {
  @override
  void initState() {
    getIt.pushNewScope();
    widget.module.init();
    super.initState();
  }

  @override
  void dispose() {
    getIt.popScope();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
