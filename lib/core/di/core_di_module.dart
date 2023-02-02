import 'package:kanban_board/core/data/db/database.dart';
import 'package:kanban_board/core/di/base_di_module.dart';

class CoreDiModule extends BaseDIModule {
  @override
  void init() async {
    getIt.registerSingleton(Database());
  }
}

class CoreModule {
  CoreModule._();
}
