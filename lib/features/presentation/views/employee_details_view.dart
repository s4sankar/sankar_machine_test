import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';

class EmployeeDetailsView extends StatelessWidget {
  final EmployeesEntity employee;
  const EmployeeDetailsView({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                employee.profileImage.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: employee.profileImage,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.black,
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        height: 60,
                        width: 60,
                      ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmployeeData(
                        field: 'Name',
                        value: employee.name,
                        fontSize: 15,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      EmployeeData(
                        field: 'Username',
                        value: employee.username,
                        fontSize: 15,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      EmployeeData(
                        field: 'Email',
                        value: employee.email,
                        fontSize: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            EmployeeData(
              field: 'Address',
              value: employee.address != null
                  ? '${employee.address!.suite}\n${employee.address!.street}\n${employee.address!.city}\n${employee.address!.zipcode}'
                  : 'Not Available',
              fontSize: 15,
            ),
            const SizedBox(
              height: 16,
            ),
            EmployeeData(
              field: 'Latitude & Longitude',
              value: (employee.address != null && employee.address!.geo != null)
                  ? '${employee.address!.geo!.lat}, ${employee.address!.geo!.lng}'
                  : 'Not Available',
              fontSize: 15,
            ),
            const SizedBox(
              height: 16,
            ),
            EmployeeData(
              field: 'Phone',
              value: employee.phone != '' ? employee.phone : 'Not Available',
              fontSize: 15,
            ),
            const SizedBox(
              height: 16,
            ),
            EmployeeData(
              field: 'Website',
              value: employee.website,
              fontSize: 15,
            ),
            const SizedBox(
              height: 16,
            ),
            EmployeeData(
              field: 'Company',
              value: employee.company != null
                  ? '${employee.company!.name}\n${employee.company!.catchPhrase}\n${employee.company!.bs}'
                  : 'Not Available',
              fontSize: 15,
            )
          ],
        ),
      ),
    );
  }
}

class EmployeeData extends StatelessWidget {
  final String field;
  final String value;
  final double fontSize;

  const EmployeeData({
    Key? key,
    required this.field,
    required this.value,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            field,
          ),
        ),
        const Text(' :  '),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}
