import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EmployeesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEmployees extends EmployeesEvent {}

class SearchEmployee extends EmployeesEvent {
  final String searchTerm;

  SearchEmployee(this.searchTerm);

  @override
  List<Object> get props => [
        searchTerm,
      ];
}
