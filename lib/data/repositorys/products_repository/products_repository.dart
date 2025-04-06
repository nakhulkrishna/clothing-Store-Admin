import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:thestyldclubadmin/features/media/models/products_category_model.dart';
import 'package:thestyldclubadmin/features/media/models/products_model.dart';

class ProductsRepository extends GetxController {
  static ProductsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> createProduct(ProductModel product) async {
    try {
      final result = await _db.collection("Products").add(product.toJson());
      return result.id;
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

  Future<String> createProductCategory(
    ProductsCategoryModel productCategory,
  ) async {
    try {
      final result = await _db
          .collection("ProductsCategory")
          .add(productCategory.toJson());
      return result.id;
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

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection("Products").doc(product.id).update(product.toJson());
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

  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try {
      await _db.collection("Products").doc(id).update(data);
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

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
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

  Future<List<ProductsCategoryModel>> getProductsCategories(
    String productId,
  ) async {
    try {
      final snapshot =
          await _db
              .collection("ProductsCategory")
              .where('productId', isEqualTo: productId)
              .get();
      return snapshot.docs
          .map(
            (querySnapshot) =>
                ProductsCategoryModel.fromSnapshot(querySnapshot),
          )
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

  Future<void> deleteProduct(ProductModel product) async {
    try {
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection("Products").doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception("Product not founded");
        }

        final productsCategoriesSnapShot =
            await _db
                .collection("ProductCategory")
                .where("productId", isEqualTo: product.id)
                .get();
        final productsCategories = productsCategoriesSnapShot.docs.map(
          (e) => ProductsCategoryModel.fromSnapshot(e),
        );

        if (productsCategories.isNotEmpty) {
          for (var productsCategoroy in productsCategories) {
            transaction.delete(
              _db.collection("Productcategory").doc(productsCategoroy.id),
            );
          }
        }

        transaction.delete(productRef);
      });
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
