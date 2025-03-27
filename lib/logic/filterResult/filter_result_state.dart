part of 'filter_result_cubit.dart';

class FilterResultState extends Equatable {
  const FilterResultState();

  @override
  List<Object> get props => [];
}

class FilterResultInitial extends FilterResultState {}

// ignore: must_be_immutable
class FilterResultLoadedState extends FilterResultState {
  List<DiamondData> filteredDiamondData;
  final double random;

  FilterResultLoadedState({
    required this.filteredDiamondData,
    required this.random,
  });

  FilterResultLoadedState copyWith({
    required List<DiamondData>? filteredDiamondData,
    double? random,
  }) {
    return FilterResultLoadedState(
      filteredDiamondData: filteredDiamondData ?? this.filteredDiamondData,
      random: random ?? this.random,
    );
  }

  @override
  List<Object> get props => [filteredDiamondData, random];
}

class FilterResultErrorState extends FilterResultState {}
