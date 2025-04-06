// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thestyldclubadmin/common/utils/formatters/formatter.dart';

class CategoryModel {
  String name;
  String id;
  String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel({
    required this.name,
    required this.id,
    required this.image,
    this.parentId = "",
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  static CategoryModel empty() =>
      CategoryModel(name: "", id: "", image: "", isFeatured: false);
  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedupdatedDate => TFormatter.formatDate(updatedAt);
  toJson() {
    return {
      'Name': name,
      "Image": image,
      'ParentId': parentId,
      "isFeatured": isFeatured,
      "createdAt": createdAt,
      "updatedAt": updatedAt = DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        name: data['Name'] ?? "",
        id: document.id,
        image: data["Image"] ?? "",
        parentId: data["ParentId"] ?? "",
        isFeatured: data["isFeatured"] ?? false,
        createdAt:
            data.containsKey("createdAt") ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey("updatedAt") ? data['updatedAt']?.toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
