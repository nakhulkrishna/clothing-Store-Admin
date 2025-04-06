// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BrandCategoriesModel {
  String? id;
  final String brandId;
  final String categoryid;
  BrandCategoriesModel({
    this.id,
    required this.brandId,
    required this.categoryid,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'brandId': brandId, 'categoryid': categoryid};
  }

  factory BrandCategoriesModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandCategoriesModel(
      id: snapshot.id,
      brandId: data['brandId'] as String,
      categoryid: data['categoryid'] as String,
    );
  }

  
}
