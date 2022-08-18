import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sankar_machine_test/features/domain/usecases/fetch_employees_usecase.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_event.dart';
import 'package:sankar_machine_test/features/presentation/bloc/employees_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

class EmployeeBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final FetchEmployeesUsecase fetchEmployeesUsecase;

  EmployeeBloc({
    required FetchEmployeesUsecase fetchEmployees,
  })  : fetchEmployeesUsecase = fetchEmployees,
        super(Empty()) {
    on<FetchEmployees>(_onEmployeeListInit);
    on<SearchEmployee>(_onSearchEmployee);
  }

  Future<void> _onEmployeeListInit(
    FetchEmployees event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(Loading());
    final results = await fetchEmployeesUsecase(const SearchParams());
    results.fold(
      (failure) => emit(
        Error(message: serverFailureMessage),
      ),
      (responseData) => emit(
        Loaded(employees: responseData),
      ),
    );
  }

  Future<void> _onSearchEmployee(
    SearchEmployee event,
    Emitter<EmployeesState> emit,
  ) async {
    final results =
        await fetchEmployeesUsecase(SearchParams(searchTerm: event.searchTerm));
    results.fold(
      (failure) => emit(
        Error(message: serverFailureMessage),
      ),
      (responseData) => emit(
        Loaded(employees: responseData),
      ),
    );
  }
}
