import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/base/base_bloc.dart';
import 'package:kanban_board/core/base/base_event.dart';

mixin AddEvent<BlocT extends BaseBloc<EventT, dynamic>, EventT extends BaseEvent> on StatelessWidget {
  void add(BuildContext context, EventT event) => context.read<BlocT>().add(event);
}

mixin AddEventStateful<WidgetT extends StatefulWidget, BlocT extends BaseBloc<EventT, dynamic>,
    EventT extends BaseEvent> on State<WidgetT> {
  void add(EventT event) => context.read<BlocT>().add(event);
}
