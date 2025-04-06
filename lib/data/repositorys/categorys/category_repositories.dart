import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class CategoryRepositories extends GetxController {
  static CategoryRepositories get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //*GET ALL CATEGORIES
  Future<List<CategoryModel>> getALlCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final result =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();

      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> createCategories(CategoryModel model) async {
    try {
      final data = await _db.collection("Categories").add(model.toJson());

      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateCategories(CategoryModel model) async {
    try {
      await _db.collection("Categories").doc(model.id).update(model.toJson());
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteCategories(String id) async {
    try {
     await _db.collection("Categories").doc(id).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
