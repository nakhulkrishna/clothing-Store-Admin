import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductsCategoryModel {
  final String id;
  final String productId;
  final String categoryid;
  ProductsCategoryModel({
    this.id = '',
    required this.productId,
    required this.categoryid,
  });

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'categoryid': categoryid};
  }

  factory ProductsCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return ProductsCategoryModel(
      id: snapshot.id,
      productId: data['productId'] as String,
      categoryid: data['categoryid'] as String,
    );
  }
}
