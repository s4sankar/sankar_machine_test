import 'package:dartz/dartz.dart';
import 'package:sankar_machine_test/core/error/failures.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';

abstract class EmployeesRepository {
  Future<Either<Failure, List<EmployeesEntity>>> fetchEmployees(
      {String? searchTerm});
}
