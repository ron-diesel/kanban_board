import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/features/board/di/module.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_bloc.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_state.dart';
import 'package:provider/provider.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundVariant,
      body: ChangeNotifierProvider<ScrollController>(
        create: (_) => ScrollController(),
        child: BlocBuilder<BoardBloc, BoardState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: context.read<ScrollController>(),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              scrollDirection: Axis.horizontal,
              child: Row(children: state.columns.map((column) => BoardModule.columnWidget(column)).toList()),
            );
          },
        ),
      ),
    );
  }
}
