import 'package:equatable/equatable.dart';
import 'package:sankar_machine_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sankar_machine_test/core/usecases/usecase.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';
import 'package:sankar_machine_test/features/domain/repositories/employees_repository.dart';

class FetchEmployeesUsecase
    implements UseCase<List<EmployeesEntity>, SearchParams> {
  final EmployeesRepository repository;

  FetchEmployeesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<EmployeesEntity>>> call(SearchParams params) {
    return repository.fetchEmployees(searchTerm: params.searchTerm);
  }
}

class SearchParams extends Equatable {
  final String? searchTerm;

  const SearchParams({this.searchTerm});

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}
