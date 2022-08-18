import 'package:sankar_machine_test/features/data/models/employees_model.dart';

abstract class EmployeesLocalDataSource {
  /// Gets cached [EmployeeModel] which was saved
  /// Throws [CacheException] for all errors
  Future<List<EmployeesModel>> fetchCachedEmployees();

  // Caches the data fetched from Server
  Future<void> cacheEmployees(List<EmployeesModel> employeesToCache);
}

class EmployeesLocalDataSourceImpl implements EmployeesLocalDataSource {
  @override
  Future<void> cacheEmployees(List<EmployeesModel> employeesToCache) {
    throw UnimplementedError();
  }

  @override
  Future<List<EmployeesModel>> fetchCachedEmployees() {
    throw UnimplementedError();
  }
}
