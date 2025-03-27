class DiamondDataModel {
  List<DiamondData>? diamondData;

  DiamondDataModel({this.diamondData});

  DiamondDataModel.fromJson(Map<String, dynamic> json) {
    if (json['diamond-data'] != null) {
      diamondData = <DiamondData>[];
      json['diamond-data'].forEach((v) {
        diamondData!.add(DiamondData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (diamondData != null) {
      data['diamond-data'] = diamondData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiamondData {
  int? qty;
  String? lotID;
  String? size;
  double? carat;
  String? lab;
  String? shape;
  String? color;
  String? clarity;
  String? cut;
  String? polish;
  String? symmetry;
  String? fluorescence;
  double? discount;
  double? perCaratRate;
  double? finalAmount;
  String? keyToSymbol;
  String? labComment;

  DiamondData({
    this.qty,
    this.lotID,
    this.size,
    this.carat,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
    this.cut,
    this.polish,
    this.symmetry,
    this.fluorescence,
    this.discount,
    this.perCaratRate,
    this.finalAmount,
    this.keyToSymbol,
    this.labComment,
  });

  DiamondData.fromJson(Map<String, dynamic> json) {
    qty = json['Qty'];
    lotID = json['Lot ID'];
    size = json['Size'];
    carat = double.parse(json['Carat'].toString());
    lab = json['Lab'].toString();
    shape = json['Shape'].toString();
    color = json['Color'].toString();
    clarity = json['Clarity'].toString();
    cut = json['Cut'];
    polish = json['Polish'];
    symmetry = json['Symmetry'];
    fluorescence = json['Fluorescence'];
    discount = double.parse(json['Discount'].toString());
    perCaratRate = double.parse(json['Per Carat Rate'].toString());
    finalAmount = double.parse(json['Final Amount'].toString());
    keyToSymbol = json['Key To Symbol'];
    labComment = json['Lab Comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Qty'] = qty;
    data['Lot ID'] = lotID;
    data['Size'] = size;
    data['Carat'] = carat;
    data['Lab'] = lab;
    data['Shape'] = shape;
    data['Color'] = color;
    data['Clarity'] = clarity;
    data['Cut'] = cut;
    data['Polish'] = polish;
    data['Symmetry'] = symmetry;
    data['Fluorescence'] = fluorescence;
    data['Discount'] = discount;
    data['Per Carat Rate'] = perCaratRate;
    data['Final Amount'] = finalAmount;
    data['Key To Symbol'] = keyToSymbol;
    data['Lab Comment'] = labComment;
    return data;
  }
}
