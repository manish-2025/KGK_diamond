// import 'package:hive/hive.dart';

// class DiamondDataModel {
//   List<DiamondData>? diamondData;

//   DiamondDataModel({this.diamondData});

//   DiamondDataModel.fromJson(Map<String, dynamic> json) {
//     if (json['diamond-data'] != null) {
//       diamondData = <DiamondData>[];
//       json['diamond-data'].forEach((v) {
//         diamondData!.add(DiamondData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (diamondData != null) {
//       data['diamond-data'] = diamondData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// @HiveType(typeId: 0)
// class DiamondData extends HiveObject {
//   @HiveField(0)
//   int? qty;
//   @HiveField(1)
//   String? lotID;
//   @HiveField(2)
//   String? size;
//   @HiveField(3)
//   double? carat;
//   @HiveField(4)
//   String? lab;
//   @HiveField(5)
//   String? shape;
//   @HiveField(6)
//   String? color;
//   @HiveField(7)
//   String? clarity;
//   @HiveField(8)
//   String? cut;
//   @HiveField(9)
//   String? polish;
//   @HiveField(10)
//   String? symmetry;
//   @HiveField(11)
//   String? fluorescence;
//   @HiveField(13)
//   double? discount;
//   @HiveField(14)
//   double? perCaratRate;
//   @HiveField(15)
//   double? finalAmount;
//   @HiveField(16)
//   String? keyToSymbol;
//   @HiveField(17)
//   String? labComment;

//   DiamondData({
//     this.qty,
//     this.lotID,
//     this.size,
//     this.carat,
//     this.lab,
//     this.shape,
//     this.color,
//     this.clarity,
//     this.cut,
//     this.polish,
//     this.symmetry,
//     this.fluorescence,
//     this.discount,
//     this.perCaratRate,
//     this.finalAmount,
//     this.keyToSymbol,
//     this.labComment,
//   });

//   DiamondData copyWith({
//     int? qty,
//     String? lotID,
//     String? size,
//     double? carat,
//     String? lab,
//     String? shape,
//     String? color,
//     String? clarity,
//     String? cut,
//     String? polish,
//     String? symmetry,
//     String? fluorescence,
//     double? discount,
//     double? perCaratRate,
//     double? finalAmount,
//     String? keyToSymbol,
//     String? labComment,
//   }) {
//     return DiamondData(
//       qty: qty ?? this.qty,
//       lotID: lotID ?? this.lotID,
//       size: size ?? this.size,
//       carat: carat ?? this.carat,
//       lab: lab ?? this.lab,
//       shape: shape ?? this.shape,
//       color: color ?? this.color,
//       clarity: clarity ?? this.clarity,
//       cut: cut ?? this.cut,
//       polish: polish ?? this.polish,
//       symmetry: symmetry ?? this.symmetry,
//       fluorescence: fluorescence ?? this.fluorescence,
//       discount: discount ?? this.discount,
//       perCaratRate: perCaratRate ?? this.perCaratRate,
//       finalAmount: finalAmount ?? this.finalAmount,
//       keyToSymbol: keyToSymbol ?? this.keyToSymbol,
//       labComment: labComment ?? this.labComment,
//     );
//   }

//   DiamondData.fromJson(Map<String, dynamic> json) {
//     qty = json['Qty'];
//     lotID = json['Lot ID'];
//     size = json['Size'];
//     carat = double.parse(json['Carat'].toString());
//     lab = json['Lab'].toString();
//     shape = json['Shape'].toString();
//     color = json['Color'].toString();
//     clarity = json['Clarity'].toString();
//     cut = json['Cut'];
//     polish = json['Polish'];
//     symmetry = json['Symmetry'];
//     fluorescence = json['Fluorescence'];
//     discount = double.parse(json['Discount'].toString());
//     perCaratRate = double.parse(json['Per Carat Rate'].toString());
//     finalAmount = double.parse(json['Final Amount'].toString());
//     keyToSymbol = json['Key To Symbol'];
//     labComment = json['Lab Comment'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Qty'] = qty;
//     data['Lot ID'] = lotID;
//     data['Size'] = size;
//     data['Carat'] = carat;
//     data['Lab'] = lab;
//     data['Shape'] = shape;
//     data['Color'] = color;
//     data['Clarity'] = clarity;
//     data['Cut'] = cut;
//     data['Polish'] = polish;
//     data['Symmetry'] = symmetry;
//     data['Fluorescence'] = fluorescence;
//     data['Discount'] = discount;
//     data['Per Carat Rate'] = perCaratRate;
//     data['Final Amount'] = finalAmount;
//     data['Key To Symbol'] = keyToSymbol;
//     data['Lab Comment'] = labComment;
//     return data;
//   }
// }
