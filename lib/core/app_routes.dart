import 'package:flutter/material.dart';
import 'package:kanban_board/features/board/di/module.dart';

class AppRoutes {
  static const String board = '/';
  static const String next = '/next';

  static Map<String, WidgetBuilder> get routes => {
        board: (context) => BoardModule.boardWidget,
        next: (context) => const Text('next'),
      };
}
