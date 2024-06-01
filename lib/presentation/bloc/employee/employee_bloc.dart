import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tusk_app/data/models/user.dart';
import 'package:tusk_app/data/source/user_source.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<OnFetchEmployee>((event, emit) async {
      // TODO: implement event handler
      emit(EmployeeLoading());
      List<User>? result = await UserSource.getEmployee();

      if(result==null) {
        emit(EmployeeFailed('Something went wrong'));
      } else {
        emit(EmployeeLoaded(result));
      }
    });
  }
}
