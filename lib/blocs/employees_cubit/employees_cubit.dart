import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isupply/backend/middleware.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final ApiService api;
  EmployeesCubit(this.api) : super(EmployeesInitial());
  static EmployeesCubit of(BuildContext context) => BlocProvider.of(context);
}
