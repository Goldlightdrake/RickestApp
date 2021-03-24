import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickest_app/shared/enum.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState(filter: Filter.none));

  void changeFilter(Filter filter) {
    emit(state.copyWith(filter: filter));
  }
}
