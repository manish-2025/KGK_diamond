import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/data/models/data_model.dart';
import 'package:kgk_diamond/data/repositories/data_repository.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiamondDataCubit extends Cubit<DiamondDataState> {
  DiamondDataCubit() : super(DiamondDataBlocInitial()) {
    fetchData();
  }

  TextEditingController fromCarateController = TextEditingController();
  TextEditingController toCarateController = TextEditingController();
  List<double> selectedCarates = [];
  List<String> selectedLabs = [];
  List<String> selectedShapes = [];
  List<String> selectedColors = [];
  List<String> selectedClarities = [];

  DataRepository dataRepository = DataRepository();
  List<double> carates = [];
  List<String> labs = [];
  List<String> shapes = [];
  List<String> color = [];
  List<String> clarity = [];
  List<DiamondEntity> myCardItem = [];
  List<DiamondEntity> diamondData = [];
  List<DiamondEntity> filteredDiamondData = [];

  void fetchData() async {
    try {
      DiamondDataModel diamondDataModel =
          await dataRepository.fetchDiamondData();
      diamondData = diamondDataModel.diamondData ?? [];

      if (diamondData.isNotEmpty) {
        carates.addAll(diamondData.map((ddata) => ddata.carat));
        labs.addAll(diamondData.map((ddata) => ddata.lab));
        shapes.addAll(diamondData.map((ddata) => ddata.shape));
        color.addAll(diamondData.map((ddata) => ddata.color));
        clarity.addAll(diamondData.map((ddata) => ddata.clarity));

        carates.sort();
        labs.sort();
        shapes.sort();
        color.sort();
        clarity.sort();

        emit(
          DiamondDataLoadedState(
            diamondData: diamondData,
            carates: carates.toSet().toList(),
            labs: labs.toSet().toList(),
            shapes: shapes.toSet().toList(),
            color: color.toSet().toList(),
            clarity: clarity.toSet().toList(),
            filteredDiamondData: [],
            random: Random().nextDouble(),
          ),
        );
      } else {
        emit(DiamondDataErrorState(error: "There is no diamon avalable"));
      }
    } catch (ex) {
      emit(DiamondDataErrorState(error: "$ex"));
    }
  }

  void updateState({required DiamondDataLoadedState loadedState}) {
    emit(
      DiamondDataLoadedState(
        carates: loadedState.carates,
        labs: loadedState.labs,
        shapes: loadedState.shapes,
        color: loadedState.color,
        clarity: loadedState.clarity,
        diamondData: loadedState.diamondData,
        filteredDiamondData: [],
        random: Random().nextDouble(),
      ),
    );
  }

  void updateSelectedCarates({
    required DiamondDataLoadedState loadedState,
    required double item,
  }) {
    if (selectedCarates.contains(item)) {
      selectedCarates.remove(item);
    } else {
      selectedCarates.add(item);
    }
    updateState(loadedState: loadedState);
  }

  void updateSelectedLabs({
    required DiamondDataLoadedState loadedState,
    required String item,
  }) {
    if (selectedLabs.contains(item)) {
      selectedLabs.remove(item);
    } else {
      selectedLabs.add(item);
    }
    updateState(loadedState: loadedState);
  }

  void updateSelectedShapes({
    required DiamondDataLoadedState loadedState,
    required String item,
  }) {
    if (selectedShapes.contains(item)) {
      selectedShapes.remove(item);
    } else {
      selectedShapes.add(item);
    }
    updateState(loadedState: loadedState);
  }

  void updateSelectedColors({
    required DiamondDataLoadedState loadedState,
    required String item,
  }) {
    if (selectedColors.contains(item)) {
      selectedColors.remove(item);
    } else {
      selectedColors.add(item);
    }
    updateState(loadedState: loadedState);
  }

  void updateSelectedClarities({
    required DiamondDataLoadedState loadedState,
    required String item,
  }) {
    if (selectedClarities.contains(item)) {
      selectedClarities.remove(item);
    } else {
      selectedClarities.add(item);
    }
    updateState(loadedState: loadedState);
  }

  void resetFilterData({required DiamondDataLoadedState loadedState}) {
    selectedCarates.clear();
    selectedClarities.clear();
    selectedColors.clear();
    selectedLabs.clear();
    selectedClarities.clear();
    toCarateController.clear();
    fromCarateController.clear();

    emit(
      DiamondDataLoadedState(
        carates: loadedState.carates,
        labs: loadedState.labs,
        shapes: loadedState.shapes,
        color: loadedState.color,
        clarity: loadedState.clarity,
        diamondData: loadedState.diamondData,
        filteredDiamondData: [],
        random: Random().nextDouble(),
      ),
    );
  }

  void filterData({required DiamondDataLoadedState loadedState}) {
    filteredDiamondData.addAll(diamondData);

    if (fromCarateController.text.isNotEmpty ||
        toCarateController.text.isNotEmpty) {
      List<double> cData = diamondData.map((item) => item.carat).toList();
      cData.sort();
      double fromData =
          fromCarateController.text.isEmpty
              ? cData.first
              : double.parse(fromCarateController.text);
      double toData =
          toCarateController.text.isEmpty
              ? cData.last
              : double.parse(toCarateController.text);
      selectedCarates.addAll(
        cData.where((val) => val >= fromData && val <= toData).toList(),
      );
      selectedCarates.sort();

      filteredDiamondData =
          diamondData.where((data) {
            return selectedCarates.contains(data.carat);
          }).toList();
    }
    if (selectedCarates.isNotEmpty) {
      filteredDiamondData =
          diamondData.where((data) {
            return selectedCarates.contains(data.carat);
          }).toList();
    }
    filteredDiamondData.where((data) {
      return selectedClarities.contains(data.clarity);
    });

    filteredDiamondData.where((data) {
      return selectedColors.contains(data.color);
    });
    filteredDiamondData.where((data) {
      return selectedLabs.contains(data.lab);
    });
    filteredDiamondData.where((data) {
      return selectedShapes.contains(data.shape);
    });
    print("object => 2 ${filteredDiamondData.length}");
    emit(
      DiamondDataLoadedState(
        carates: loadedState.carates,
        labs: loadedState.labs,
        shapes: loadedState.shapes,
        color: loadedState.color,
        clarity: loadedState.clarity,
        diamondData: loadedState.diamondData,
        filteredDiamondData: filteredDiamondData,
        random: Random().nextDouble(),
      ),
    );
  }
}
