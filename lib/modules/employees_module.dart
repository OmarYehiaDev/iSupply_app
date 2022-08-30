import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:isupply/backend/middleware.dart';
import 'package:isupply/blocs/employees_cubit/employees_cubit.dart';

class EmployeesModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        RedirectRoute('/employees', to: '/employees/home'),

        // TODO: edit this
        ChildRoute(
          "/home",
          child: (context, args) => BlocProvider(
            create: (context) => EmployeesCubit(ApiService()),
            child: const Scaffold(),
          ),
        ),
        ChildRoute(
          "/create_employee",
          child: (context, args) => BlocProvider(
            create: (context) => EmployeesCubit(ApiService()),
            child: const Scaffold(),
          ),
        ),
      ];
}
