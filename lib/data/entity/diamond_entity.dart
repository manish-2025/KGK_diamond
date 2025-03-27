import 'package:hive/hive.dart';
part 'diamond_entity.g.dart';

@HiveType(typeId: 0)
class DiamondEntity extends HiveObject {
  @HiveField(0)
  final int qty;
  @HiveField(1)
  final String lotID;
  @HiveField(2)
  final String size;
  @HiveField(3)
  final double carat;
  @HiveField(4)
  final String lab;
  @HiveField(5)
  final String shape;
  @HiveField(6)
  final String color;
  @HiveField(7)
  final String clarity;
  @HiveField(8)
  final String cut;
  @HiveField(9)
  final String polish;
  @HiveField(10)
  final String symmetry;
  @HiveField(11)
  final String fluorescence;
  @HiveField(13)
  final double discount;
  @HiveField(14)
  final double perCaratRate;
  @HiveField(15)
  final double finalAmount;
  @HiveField(16)
  final String keyToSymbol;
  @HiveField(17)
  final String labComment;

  DiamondEntity({
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
  });

  DiamondEntity copyWith({
    int? qty,
    String? lotID,
    String? size,
    double? carat,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
    String? cut,
    String? polish,
    String? symmetry,
    String? fluorescence,
    double? discount,
    double? perCaratRate,
    double? finalAmount,
    String? keyToSymbol,
    String? labComment,
  }) {
    return DiamondEntity(
      qty: qty ?? this.qty,
      lotID: lotID ?? this.lotID,
      size: size ?? this.size,
      carat: carat ?? this.carat,
      lab: lab ?? this.lab,
      shape: shape ?? this.shape,
      color: color ?? this.color,
      clarity: clarity ?? this.clarity,
      cut: cut ?? this.cut,
      polish: polish ?? this.polish,
      symmetry: symmetry ?? this.symmetry,
      fluorescence: fluorescence ?? this.fluorescence,
      discount: discount ?? this.discount,
      perCaratRate: perCaratRate ?? this.perCaratRate,
      finalAmount: finalAmount ?? this.finalAmount,
      keyToSymbol: keyToSymbol ?? this.keyToSymbol,
      labComment: labComment ?? this.labComment,
    );
  }
}
