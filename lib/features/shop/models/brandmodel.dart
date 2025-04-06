// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:thestyldclubadmin/common/utils/formatters/formatter.dart';
// import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Brandmodel {
//   String id;
//   String image;
//   String name;
//   bool isFeatured;
//   int? productsCount;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<CategoryModel>? brandCategories;

//   Brandmodel({
//     required this.name,
//     required this.id,
//     required this.image,
//     this.isFeatured = false,
//     this.productsCount,
//     this.createdAt,
//     this.updatedAt,
//     this.brandCategories,
//   });

//   /// Returns an empty `Brandmodel` instance
//   static Brandmodel empty() => Brandmodel(image: "", id: "", name: "");

//   /// Formatted Date for UI display
//   String get formattedDate => TFormatter.formatDate(createdAt);
//   String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

//   /// Converts object to JSON format
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "image": image,
//       "name": name,
//       "isFeatured": isFeatured,
//       "productsCount": productsCount ?? 0,
//       "createdAt": createdAt?.toIso8601String(),
//       "updatedAt":
//           updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
//       "brandCategories": brandCategories?.map((e) => e.toJson()).toList(),
//     };
//   }

//   /// Converts Firestore snapshot to `Brandmodel`
//   factory Brandmodel.fromSnapshot(
//     DocumentSnapshot<Map<String, dynamic>> document,
//   ) {
//     if (document.data() != null) {
//       final data = document.data()!;
//       return Brandmodel(
//         id: document.id,
//         image: data['image'] ?? "",
//         name: data['name'] ?? "",
//         isFeatured: data['isFeatured'] ?? false,
//         productsCount: data['productsCount'] ?? "",
//         createdAt:
//             data.containsKey("createdAt") ? data["createdAt"]?.toDate() : null,
//         updatedAt:
//             data.containsKey("updatedAt") ? data["updatedAt"]?.toDate() : null,
//       );
//     } else {
//       return Brandmodel.empty();
//     }
//   }

//   /// Converts JSON map to `Brandmodel`
//   factory Brandmodel.fromJson(Map<String, dynamic> document) {
//     final data = document;
//     if (data.isEmpty) return Brandmodel.empty();
//     return Brandmodel(
//       id: data['id'] ?? "",
//       image: data['image'] ?? "",
//       name: data['name'] ?? "",
//       isFeatured: data['isFeatured'] ?? false,
//       productsCount: int.parse((data["ProductsCount"] ?? 0).toString()),
//       createdAt:
//           data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null,
//       updatedAt:
//           data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
//     );
//   }
// }

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thestyldclubadmin/common/utils/formatters/formatter.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class Brandmodel {
  String id;
  String image;
  String name;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CategoryModel>? brandCategories;

  Brandmodel({
    required this.name,
    required this.id,
    required this.image,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  static Brandmodel empty() => Brandmodel(image: "", id: "", name: "");

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "isFeatured": isFeatured,
      "productsCount": productsCount ?? 0,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt":
          updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      "brandCategories": brandCategories?.map((e) => e.toJson()).toList(),
    };
  }

  factory Brandmodel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) return Brandmodel.empty();

    return Brandmodel(
      id: document.id,
      image: data['image'] ?? "",
      name: data['name'] ?? "",
      isFeatured: data['isFeatured'] ?? false,
      productsCount:
          (data['productsCount'] ?? 0) is int
              ? data['productsCount']
              : int.tryParse(data['productsCount'].toString()),
      createdAt: _parseTimestampOrString(data['createdAt']),
      updatedAt: _parseTimestampOrString(data['updatedAt']),
    );
  }

  factory Brandmodel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return Brandmodel.empty();

    return Brandmodel(
      id: data['id'] ?? "",
      image: data['image'] ?? "",
      name: data['name'] ?? "",
      isFeatured: data['isFeatured'] ?? false,
      productsCount:
          (data["productsCount"] ?? 0) is int
              ? data["productsCount"]
              : int.tryParse(data["productsCount"].toString()),
      createdAt: _parseTimestampOrString(data['createdAt']),
      updatedAt: _parseTimestampOrString(data['updatedAt']),
    );
  }

  /// Helper method to parse both Firestore Timestamp and ISO8601 String
  static DateTime? _parseTimestampOrString(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
