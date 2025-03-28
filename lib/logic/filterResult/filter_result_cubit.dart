import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/presentation/globals.dart';

part 'filter_result_state.dart';

class FilterResultCubit extends Cubit<FilterResultState> {
  FilterResultCubit() : super(FilterResultInitial());

  List<String> sortBy = [
    "",
    AppConstants.sortNon,
    AppConstants.priceL2H,
    AppConstants.priceH2L,
    AppConstants.carateL2H,
    AppConstants.carateH2L,
  ];
  List<DiamondEntity> myCardItem = [];
  List<DiamondEntity> filteredDiamondData = [];
  int filterId = 1;

  getCartData({required FilterResultLoadedState loadedState}) async {
    myCardItem = List<DiamondEntity>.from(
      await diamondBox.get(HiveConstants.MY_CART_ITEM) ?? [],
    );
    emit(
      loadedState.copyWith(
        filteredDiamondData: filteredDiamondData,
        myCardItem: myCardItem,
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
        filteredDiamondData: filteredDiamondData,
        myCardItem: myCardItem,
        random: Random().nextDouble(),
      ),
    );
  }

  Future<int> setFilterId({
    required int fId,
    required FilterResultLoadedState filterState,
  }) {
    filterId = fId;
    emit(
      filterState.copyWith(
        filteredDiamondData: filterState.filteredDiamondData,
        random: Random().nextDouble(),
      ),
    );
    return Future.value(1);
  }

  void sortById({
    required int fId,
    required FilterResultLoadedState loadedState,
  }) {
    List<DiamondEntity> dataToFilter = [];

    if (fId == 2) {
      dataToFilter.addAll(loadedState.filteredDiamondData);
      dataToFilter.sort((a, b) => a.finalAmount.compareTo(b.finalAmount));
    }
    if (fId == 3) {
      dataToFilter.addAll(loadedState.filteredDiamondData);
      dataToFilter.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
    }
    if (fId == 4) {
      dataToFilter.addAll(loadedState.filteredDiamondData);
      dataToFilter.sort((a, b) => a.carat.compareTo(b.carat));
    }
    if (fId == 5) {
      dataToFilter.addAll(loadedState.filteredDiamondData);
      dataToFilter.sort((a, b) => b.carat.compareTo(a.carat));
    }

    filteredDiamondData.clear();
    filteredDiamondData.addAll(dataToFilter);
    filterId = fId;
    emit(
      loadedState.copyWith(
        filteredDiamondData: dataToFilter,
        myCardItem: myCardItem,
        random: Random().nextDouble(),
      ),
    );
  }

  int sortByL2H(DiamondEntity a, DiamondEntity b) {
    return b.finalAmount.compareTo(a.finalAmount);
  }

  int sortByH2L(DiamondEntity a, DiamondEntity b) {
    return (a).finalAmount.compareTo(b.finalAmount);
  }

  void getFilteredData({required DiamondDataCubit diamondDataCubit}) {
    filteredDiamondData.clear();
    filterId = 1;
    filteredDiamondData.addAll(diamondDataCubit.filteredDiamondData);
    FilterResultLoadedState loadedState = FilterResultLoadedState(
      filteredDiamondData: filteredDiamondData,
      random: Random().nextDouble(),
    );
    getCartData(loadedState: loadedState);
  }
}
