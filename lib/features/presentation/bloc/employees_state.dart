import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';

@immutable
abstract class EmployeesState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends EmployeesState {}

class Loading extends EmployeesState {}

class Loaded extends EmployeesState {
  final List<EmployeesEntity> employees;

  Loaded({required this.employees});

  @override
  List<Object> get props => [
        employees,
      ];
}

class Error extends EmployeesState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [
        message,
      ];
}
