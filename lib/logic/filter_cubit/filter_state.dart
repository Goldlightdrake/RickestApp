part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final Filter filter;
  FilterState({
    required this.filter,
  });

  FilterState copyWith({
    Filter? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [filter];
}
