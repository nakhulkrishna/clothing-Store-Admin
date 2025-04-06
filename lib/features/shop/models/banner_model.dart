import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerModel {
  String? id;
  String image;
  String targetScreen;
  bool active;
  BannerModel({
    this.id,
    required this.image,
    required this.targetScreen,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'image': image,
      'targetScreen': targetScreen,
      'active': active,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      image: data['image'] ?? "",
      targetScreen: data['targetScreen'] ?? "",
      active: data['active'] ?? false,
    );
  }
}
