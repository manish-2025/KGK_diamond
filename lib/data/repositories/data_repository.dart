import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kgk_diamond/data/models/data_model.dart';

class DataRepository {
  Future<DiamondDataModel> fetchDiamondData() async {
    try {
      var jsonData = await rootBundle.loadString("assets/data.json");
      final data = DiamondDataModel.fromJson(json.decode(jsonData));
      return data;
    } catch (ex) {
      rethrow;
    }
  }
}
