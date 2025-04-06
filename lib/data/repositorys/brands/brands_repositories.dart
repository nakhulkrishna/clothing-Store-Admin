import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/firebase_exceptions.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/format_exceptions.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/platform_exceptions.dart';
import 'package:thestyldclubadmin/features/shop/models/brand_categories_model.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';

class BrandsRepositorie extends GetxController {
  static BrandsRepositorie get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Brandmodel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      return snapshot.docs.map((e) => Brandmodel.fromSnapshot(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<BrandCategoriesModel>> getAllBrandsCategories() async {
    try {
      final snapshot = await _db.collection("BrandsCategories").get();
      return snapshot.docs
          .map((e) => BrandCategoriesModel.fromSnapShot(e))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<BrandCategoriesModel>> getCategoriesOfSpecificbrand(
    String brandId,
  ) async {
    try {
      final snapshot =
          await _db
              .collection("BrandsCategories")
              .where('brandId', isEqualTo: brandId)
              .get();
      return snapshot.docs
          .map((e) => BrandCategoriesModel.fromSnapShot(e))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createBrands(Brandmodel brand) async {
    try {
      final result = await _db.collection("Brands").add(brand.toJson());
      return result.id;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createBrandCategories(
    BrandCategoriesModel brandCategories,
  ) async {
    try {
      final result = await _db
          .collection("BrandsCategories")
          .add(brandCategories.toJson());
      return result.id;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateBrands(Brandmodel brand) async {
    try {
      await _db.collection("Brands").doc(brand.id).update(brand.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteBrands(Brandmodel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db
            .collection("Brands")
            .doc(brand.id); // ✅ Fix: "Brands", not "brands"
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception("Brand not found");
        }

        final brandCategoriesSnapShot =
            await _db
                .collection("BrandsCategories")
                .where("brandId", isEqualTo: brand.id)
                .get();

        for (var doc in brandCategoriesSnapShot.docs) {
          transaction.delete(_db.collection("BrandsCategories").doc(doc.id));
        }

        transaction.delete(brandRef);
      });
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteBrandsCategories(String brandCategoriesId) async {
    try {
      await _db
          .collection("BrandsCategories")
          .doc(brandCategoriesId)
          .delete(); // ✅ Fix: correct collection
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }
}
