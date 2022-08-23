import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:sankar_machine_test/core/network/network_info.dart';
import 'package:sankar_machine_test/features/data/datasources/employees_remote_datasource.dart';
import 'package:sankar_machine_test/features/data/repositories/employees_repository_impl.dart';
import 'package:sankar_machine_test/features/domain/repositories/employees_repository.dart';
import 'package:sankar_machine_test/features/domain/usecases/fetch_employees_usecase.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_bloc.dart';
import 'package:http/http.dart' as http;

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => EmployeeBloc(
      fetchEmployees: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => FetchEmployeesUsecase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<EmployeeRemoteDatasourceImpl>(
    () => EmployeeRemoteDatasourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<EmployeesRepository>(
    () => EmployeesRepositoryImpl(
      employeeRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
