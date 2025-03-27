import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/presentation/globals.dart';

part 'filter_result_state.dart';

class FilterResultCubit extends Cubit<FilterResultState> {
  FilterResultCubit() : super(FilterResultInitial());

  List<DiamondEntity> myCardItem = [];

  getCartData() async {
    myCardItem = List<DiamondEntity>.from(
      await diamondBox.get(HiveConstants.MY_CART_ITEM) ?? [],
    );
    emit(
      FilterResultLoadedState(
        filteredDiamondData: myCardItem,
        random: Random().nextDouble(),
      ),
    );
  }

  void addToCart({
    required List<DiamondEntity> diamondData,
    required DiamondEntity item,
  }) async {
    bool existsByName = myCardItem.any((person) {
      return person.lotID == item.lotID;
    });

    if (existsByName) {
      myCardItem.remove(item);
    } else {
      myCardItem.add(item);
    }

    await diamondBox.put(HiveConstants.MY_CART_ITEM, myCardItem);
    hiveCardData.addAll(await diamondBox.get(HiveConstants.MY_CART_ITEM));

    emit(
      FilterResultLoadedState(
        filteredDiamondData: diamondData,
        random: Random().nextDouble(),
      ),
    );
  }
}
