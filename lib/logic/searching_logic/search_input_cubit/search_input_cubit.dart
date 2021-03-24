import 'package:bloc/bloc.dart';

class SearchInputCubit extends Cubit<bool> {
  SearchInputCubit() : super(false);

  void toggleForInputView(bool value) {
    emit(value);
  }
}
