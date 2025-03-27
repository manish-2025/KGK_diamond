// ignore_for_file: annotate_overrides, overridden_fields

import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/data/model_response.dart';

class DiamondDataModel extends ModelResponseExtend {
  final List<DiamondEntity>? diamondData;

  DiamondDataModel({this.diamondData});

  factory DiamondDataModel.fromJson(Map<String, dynamic> json) {
    return DiamondDataModel(
      diamondData:
          (json['diamond-data'] != null)
              ? List<DiamondData>.from(
                json['diamond-data']
                    .map((v) => DiamondData.fromJson(v))
                    .toList(),
              )
              : [],
    );
  }
}

class DiamondData extends DiamondEntity {
  int qty;
  String lotID;
  String size;
  double carat;
  String lab;
  String shape;
  String color;
  String clarity;
  String cut;
  String polish;
  String symmetry;
  String fluorescence;
  double discount;
  double perCaratRate;
  double finalAmount;
  String keyToSymbol;
  String labComment;

  DiamondData({
    required this.qty,
    required this.lotID,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
  }) : super(
         qty: qty,
         lotID: lotID,
         size: size,
         carat: carat,
         lab: lab,
         shape: shape,
         color: color,
         clarity: clarity,
         cut: cut,
         polish: polish,
         symmetry: symmetry,
         fluorescence: fluorescence,
         discount: discount,
         perCaratRate: perCaratRate,
         finalAmount: finalAmount,
         keyToSymbol: keyToSymbol,
         labComment: labComment,
       );

  factory DiamondData.fromJson(Map<String, dynamic> json) {
    return DiamondData(
      qty: json['Qty'],
      lotID: json['Lot ID'].toString(),
      size: json['Size'].toString(),
      carat: double.parse(json['Carat'].toString()),
      lab: json['Lab'].toString(),
      shape: json['Shape'].toString(),
      color: json['Color'].toString(),
      clarity: json['Clarity'].toString(),
      cut: json['Cut'].toString(),
      polish: json['Polish'].toString(),
      symmetry: json['Symmetry'].toString(),
      fluorescence: json['Fluorescence'].toString(),
      discount: double.parse(json['Discount'].toString()),
      perCaratRate: double.parse(json['Per Carat Rate'].toString()),
      finalAmount: double.parse(json['Final Amount'].toString()),
      keyToSymbol: json['Key To Symbol'].toString(),
      labComment: json['Lab Comment'].toString(),
    );
  }
}
