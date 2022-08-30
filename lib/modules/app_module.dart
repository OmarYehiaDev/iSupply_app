import 'package:flutter_modular/flutter_modular.dart';

import 'auth_module.dart';
import 'employees_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        RedirectRoute('/', to: '/auth'),
        // [Auth]
        ModuleRoute(
          "/auth",
          module: AuthModule(),
        ),
        // [Employees]
        ModuleRoute(
          "/employees",
          module: EmployeesModule(),
        ),
      ];
}
