import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // -------------------------------//
  // 🟢 Add New Order
  // -------------------------------//
  Future<void> addOrder(Ordermodel order) async {
    try {
      await _db.collection("Orders").add(order.toJson());
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

  // -------------------------------//
  // 🟡 Update Specific Fields in Order
  // -------------------------------//
  Future<void> updateOrderSpecificValue(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection("Orders").doc(id).update(data);
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

  // -------------------------------//
  // 🔵 Get All Orders (Sorted by Date)
  // -------------------------------//
  Future<List<Ordermodel>> getAllOrders() async {
    try {
      final result =
          await _db
              .collection("Orders")
              .orderBy('orderDate', descending: true)
              .get();
      return result.docs
          .map((documentSnapshot) => Ordermodel.fromSnapshot(documentSnapshot))
          .toList();
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

  // -------------------------------//
  // 🔴 Delete Order by ID
  // -------------------------------//
  Future<void> deleteOrder(String orderId) async {
    try {
      await _db.collection("Orders").doc(orderId).delete();
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
