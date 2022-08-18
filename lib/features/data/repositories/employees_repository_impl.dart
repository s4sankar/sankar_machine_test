import 'dart:convert';

import 'package:sankar_machine_test/core/error/exceptions.dart';
import 'package:sankar_machine_test/core/network/network_info.dart';
import 'package:sankar_machine_test/core/utils/db_helper.dart';
import 'package:sankar_machine_test/features/data/datasources/employees_remote_datasource.dart';
import 'package:sankar_machine_test/features/data/models/employees_model.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';
import 'package:sankar_machine_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sankar_machine_test/features/domain/repositories/employees_repository.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  final NetworkInfo networkInfo;
  final EmployeeRemoteDatasourceImpl employeeRemoteDatasource;

  EmployeesRepositoryImpl({
    required this.networkInfo,
    required this.employeeRemoteDatasource,
  });

  @override
  Future<Either<Failure, List<EmployeesEntity>>> fetchEmployees(
      {String? searchTerm}) async {
    try {
      final employeeData = await DBHelper.getData();
      if (employeeData.isNotEmpty) {
        final result = employeeData
            .map(
              ((e) => EmployeesModel(
                    id: e['id'],
                    name: e['name'],
                    username: e['username'],
                    email: e['email'],
                    profileImage: e['profileImage'],
                    phone: e['phone'],
                    website: e['website'],
                    company: e['company'] != ''
                        ? CompanyModel.fromJson(json.decode(e['company']))
                        : null,
                    address: e['address'] != ''
                        ? AddressModel.fromJson(
                            json.decode(
                              e['address'],
                            ),
                          )
                        : null,
                  )),
            )
            .toList();

        if (searchTerm != null && searchTerm.isNotEmpty) {
          final filteredList = result
              .where((element) =>
                  element.name
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase()) ||
                  element.email
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase()))
              .toList();
          return Right(filteredList);
        }
        return Right(result);
      } else {
        if (await networkInfo.isConnected) {
          final result = await employeeRemoteDatasource.fetchEmployees();
          for (EmployeesModel element in result) {
            DBHelper.insert({
              'id': element.id,
              'name': element.name,
              'username': element.username,
              'email': element.email,
              'profileImage': element.profileImage,
              'phone': element.phone,
              'website': element.website,
              'company': element.company != null
                  ? json.encode((element.company as CompanyModel).toJson())
                  : '',
              'address': element.address != null
                  ? json.encode((element.address as AddressModel).toJson())
                  : '',
            });
          }

          return Right(result);
        } else {
          return Left(ServerFailure());
        }
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
