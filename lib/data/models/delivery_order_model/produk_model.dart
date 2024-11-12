import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class DropdownProductModel extends Equatable {
  final String? name;
  final String? productCode;
  final String? description;
  final double? stock;
  final String? unit;
  final double? buyPrice;
  final String? defaultBuyAccountCode;
  final String? defaultBuyTaxName;
  final double? sellPrice;
  final String? defaultSellAccountCode;
  final String? defaultSellTaxName;
  final double? minimumStock;
  final String? productCategory;

  const DropdownProductModel({
    this.name,
    this.productCode,
    this.description,
    this.stock,
    this.unit,
    this.buyPrice,
    this.defaultBuyAccountCode,
    this.defaultBuyTaxName,
    this.sellPrice,
    this.defaultSellAccountCode,
    this.defaultSellTaxName,
    this.minimumStock,
    this.productCategory,
  });

  factory DropdownProductModel.fromJson(Map<String, dynamic> json) {
    return DropdownProductModel(
      name: json['Name'],
      productCode: json['ProductCode'],
      description: json['Description'],
      stock: json['Stock'] != null
          ? double.tryParse(json['Stock'].toString())
          : null,
      unit: json['Unit'],
      buyPrice: json['BuyPrice'] != null
          ? double.tryParse(json['BuyPrice'].toString())
          : null,
      defaultBuyAccountCode: json['DefaultBuyAccountCode'],
      defaultBuyTaxName: json['DefaultBuyTaxName'],
      sellPrice: json['SellPrice'] != null
          ? double.tryParse(json['SellPrice'].toString())
          : null,
      defaultSellAccountCode: json['DefaultSellAccountCode'],
      defaultSellTaxName: json['DefaultSellTaxName'],
      minimumStock: json['MinimumStock'] != null
          ? double.tryParse(json['MinimumStock'].toString())
          : null,
      productCategory: json['ProductCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ProductCode': productCode,
      'Description': description,
      'Stock': stock,
      'Unit': unit,
      'BuyPrice': buyPrice,
      'DefaultBuyAccountCode': defaultBuyAccountCode,
      'DefaultBuyTaxName': defaultBuyTaxName,
      'SellPrice': sellPrice,
      'DefaultSellAccountCode': defaultSellAccountCode,
      'DefaultSellTaxName': defaultSellTaxName,
      'MinimumStock': minimumStock,
      'ProductCategory': productCategory,
    };
  }

  @override
  List<Object?> get props => [productCode];

  @override
  String toString() {
    return 'DropdownProductModel(name: $name, productCode: $productCode, description: $description, stock: $stock, unit: $unit, buyPrice: $buyPrice, defaultBuyAccountCode: $defaultBuyAccountCode, defaultBuyTaxName: $defaultBuyTaxName, sellPrice: $sellPrice, defaultSellAccountCode: $defaultSellAccountCode, defaultSellTaxName: $defaultSellTaxName, minimumStock: $minimumStock, productCategory: $productCategory)';
  }

  @override
  bool operator ==(covariant DropdownProductModel other) {
    if (identical(this, other)) return true;
    return other.productCode == productCode;
  }

  @override
  int get hashCode {
    return productCode.hashCode;
  }
}

class DropdownProductModelData {
  final List<DropdownProductModel> data;

  DropdownProductModelData({
    required this.data,
  });

  factory DropdownProductModelData.fromJson(Map<String, dynamic> json) {
    return DropdownProductModelData(
      data: (json['data'] as List)
          .map((item) => DropdownProductModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'DropdownProductModelData(data: $data)';
  }

  @override
  bool operator ==(covariant DropdownProductModelData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
