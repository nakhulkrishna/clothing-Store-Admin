// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:html/dom.dart';

class ProductsVeriationModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributesValues;

  ProductsVeriationModel({
    required this.id,
    this.sku = "",
    String image = "",
    this.description = "",
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributesValues,
  }) : image = image.obs;

  static ProductsVeriationModel empty() =>
      ProductsVeriationModel(id: "", attributesValues: {});

  toJson() {
    return {
      "Id": id,
      "Image": image.value,
      "Description": description,
      "Price": price,
      "SalePrice": salePrice,
      "SKU": sku,
      "Stock": stock,
      "SoldQuantity": soldQuantity,
      "AttributesValue": attributesValues,
    };
  }

  factory ProductsVeriationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductsVeriationModel.empty();
    return ProductsVeriationModel(
      id: data["Id"] ?? "",
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? "",
      description: data["Description"],
      stock: data['Stock'] ?? 0,
      soldQuantity: data['soldQuantity'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      attributesValues: Map<String, String>.from(data['AttributesValues']),
    );
  }
}
