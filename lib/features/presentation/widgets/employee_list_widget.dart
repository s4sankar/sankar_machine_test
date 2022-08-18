import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';

class EmployeeListWidget extends StatelessWidget {
  final EmployeesEntity employee;

  const EmployeeListWidget({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Row(
            children: [
              employee.profileImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: employee.profileImage,
                      height: 60,
                      width: 60,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  employee.company != null
                      ? Text(employee.company!.name)
                      : const Text('Company Name Not Available'),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
