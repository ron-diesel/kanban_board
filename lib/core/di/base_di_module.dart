import 'package:get_it/get_it.dart';
import 'package:kanban_board/core/di/core_di_module.dart';

final getIt = GetIt.instance;

Future initCoreDI() async {
  CoreDiModule().init();
}

abstract class BaseDIModule {
  void init();
}
