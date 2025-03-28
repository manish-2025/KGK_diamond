part of 'filter_result_cubit.dart';

class FilterResultState extends Equatable {
  const FilterResultState();

  @override
  List<Object> get props => [];
}

class FilterResultInitial extends FilterResultState {}

// ignore: must_be_immutable
class FilterResultLoadedState extends FilterResultState {
  List<DiamondEntity> filteredDiamondData;
  List<DiamondEntity>? myCardItem;
  final double random;

  FilterResultLoadedState({
    required this.filteredDiamondData,
    this.myCardItem,
    required this.random,
  });

  FilterResultLoadedState copyWith({
    required List<DiamondEntity>? filteredDiamondData,
    List<DiamondEntity>? myCardItem,
    double? random,
  }) {
    return FilterResultLoadedState(
      filteredDiamondData: filteredDiamondData ?? this.filteredDiamondData,
      myCardItem: myCardItem ?? this.myCardItem,
      random: random ?? this.random,
    );
  }

  @override
  List<Object> get props => [filteredDiamondData, random];
}

class FilterResultErrorState extends FilterResultState {}
