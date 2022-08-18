import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sankar_machine_test/core/network/network_info.dart';
import 'package:sankar_machine_test/features/data/datasources/employees_remote_datasource.dart';
import 'package:sankar_machine_test/features/data/repositories/employees_repository_impl.dart';
import 'package:sankar_machine_test/features/domain/usecases/fetch_employees_usecase.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_bloc.dart';
import 'package:sankar_machine_test/features/presentation/views/employees_listing_view.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => EmployeeBloc(
          fetchEmployees: FetchEmployeesUsecase(
            repository: EmployeesRepositoryImpl(
              employeeRemoteDatasource: EmployeeRemoteDatasourceImpl(
                client: http.Client(),
              ),
              networkInfo: NetworkInfoImpl(
                DataConnectionChecker(),
              ),
            ),
          ),
        ),
        child: const EmployeesListingView(),
      ),
    );
  }
}
