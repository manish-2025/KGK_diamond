import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/data/models/data_model.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';

class MyCartCubit extends Cubit<double> {
  MyCartCubit() : super(0);

  List<DiamondData> diamondData = [];

  void getCartData({
    required DiamondDataCubit diamondDataCubit,
    required FilterResultCubit filterResultCubit,
  }) {
    diamondData.clear();
    diamondData.addAll(filterResultCubit.myCardItem.toSet().toList());
    emit(Random().nextDouble());
  }

  removeFromCart({
    required DiamondData diamond,
    required FilterResultCubit filterResultCubit,
  }) {
    filterResultCubit.addToCart(
      diamondData: filterResultCubit.myCardItem,
      item: diamond,
    );
    diamondData.remove(diamond);
    emit(Random().nextDouble());
  }
}
