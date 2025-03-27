import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/data/models/data_model.dart';

part 'filter_result_state.dart';

class FilterResultCubit extends Cubit<FilterResultState> {
  FilterResultCubit() : super(FilterResultInitial());

  List<DiamondData> myCardItem = [];

  void addToCart({
    required List<DiamondData> diamondData,
    required DiamondData item,
  }) async {
    if (myCardItem.contains(item)) {
      myCardItem.remove(item);
    } else {
      myCardItem.add(item);
    }
    emit(
      FilterResultLoadedState(
        filteredDiamondData: diamondData,
        random: Random().nextDouble(),
      ),
    );
  }
}
