import 'dart:convert';

import 'package:sankar_machine_test/core/error/exceptions.dart';
import 'package:sankar_machine_test/features/data/models/employees_model.dart';
import 'package:http/http.dart' as http;

abstract class EmployeesRemoteDataSource {
  /// Calls mocky endpoint
  /// Throws [ServerException] for all errors
  Future<List<EmployeesModel>> fetchEmployees();
}

class EmployeeRemoteDatasourceImpl implements EmployeesRemoteDataSource {
  final http.Client client;
  EmployeeRemoteDatasourceImpl({required this.client});

  @override
  Future<List<EmployeesModel>> fetchEmployees() async {
    final response = await client.get(
      Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return List<EmployeesModel>.from(
          json.decode(response.body).map((x) => EmployeesModel.fromJson(x)));
    } else {
      throw ServerException();
    }
  }
}
