import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_bloc.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_event.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_state.dart';
import 'package:sankar_machine_test/features/presentation/views/employee_details_view.dart';
import 'package:sankar_machine_test/features/presentation/widgets/employee_list_widget.dart';
import 'package:sankar_machine_test/features/presentation/widgets/loading_widget.dart';
import 'package:sankar_machine_test/features/presentation/widgets/message_widget.dart';

class EmployeesListingView extends StatefulWidget {
  const EmployeesListingView({Key? key}) : super(key: key);

  @override
  State<EmployeesListingView> createState() => _EmployeesListingViewState();
}

class _EmployeesListingViewState extends State<EmployeesListingView> {
  final TextEditingController controller = TextEditingController();
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _employeeBloc = context.read<EmployeeBloc>();
      _employeeBloc.add(FetchEmployees());
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 24,
          left: 16,
          right: 16,
        ),
        child: BlocBuilder<EmployeeBloc, EmployeesState>(
            builder: (context, state) {
          if (state is Loading) {
            return const LoadingWidget();
          } else if (state is Loaded) {
            return EmployessDisplayWidget(
              employees: state.employees,
              textEditingController: controller,
              employeeSearchTextChanged: (value) {
                _employeeBloc.add(SearchEmployee(value));
              },
            );
          } else if (state is Error) {
            return MessageDisplay(
              message: state.message,
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class EmployessDisplayWidget extends StatelessWidget {
  final List<EmployeesEntity> employees;
  final TextEditingController textEditingController;
  final Function(String) employeeSearchTextChanged;
  const EmployessDisplayWidget({
    Key? key,
    required this.employees,
    required this.textEditingController,
    required this.employeeSearchTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: textEditingController,
                onChanged: ((value) => employeeSearchTextChanged(value)),
              ),
            ),
            const Icon(Icons.search),
          ],
        ),
        employees.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  'No data to display, Search again',
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Flexible(
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetailsView(
                              employee: employees[index],
                            ),
                          ),
                        );
                      },
                      child: EmployeeListWidget(
                        employee: employees[index],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
