part of 'employees_cubit.dart';

@immutable
abstract class EmployeesState {}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesSuccess extends EmployeesState {}

class EmployeesFailed extends EmployeesState {
  final String error;
  EmployeesFailed(this.error);
}
