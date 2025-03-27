import 'package:equatable/equatable.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/data/models/data_model.dart';

class DiamondDataState extends Equatable {
  const DiamondDataState();

  @override
  List<Object> get props => [];
}

class DiamondDataBlocInitial extends DiamondDataState {}

// ignore: must_be_immutable
class DiamondDataLoadedState extends DiamondDataState {
  final List<DiamondEntity> diamondData;
  List<DiamondEntity> filteredDiamondData = [];
  final List<double> carates;
  final List<String> labs;
  final List<String> shapes;
  final List<String> color;
  final List<String> clarity;
  final double random;

  DiamondDataLoadedState({
    required this.carates,
    required this.labs,
    required this.shapes,
    required this.color,
    required this.clarity,
    required this.diamondData,
    required this.filteredDiamondData,
    required this.random,
  });

  DiamondDataLoadedState copyWith({
    List<DiamondData>? diamondData,
    List<DiamondData>? filteredDiamondData,
    List<double>? carates,
    List<String>? labs,
    List<String>? shapes,
    List<String>? color,
    List<String>? clarity,
    double? random,
  }) {
    return DiamondDataLoadedState(
      diamondData: diamondData ?? this.diamondData,
      filteredDiamondData: filteredDiamondData ?? this.filteredDiamondData,
      carates: carates ?? this.carates,
      labs: labs ?? this.labs,
      shapes: shapes ?? this.shapes,
      color: color ?? this.color,
      clarity: clarity ?? this.clarity,
      random: random ?? this.random,
    );
  }

  @override
  List<Object> get props => [
    diamondData,
    filteredDiamondData,
    carates,
    labs,
    shapes,
    color,
    clarity,
    random,
  ];
}

class DiamondDataErrorState extends DiamondDataState {
  final String error;

  DiamondDataErrorState({required this.error});
}
