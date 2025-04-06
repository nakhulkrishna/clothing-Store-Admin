import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/firebase_exceptions.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/format_exceptions.dart';
import 'package:thestyldclubadmin/common/utils/exceptions/platform_exceptions.dart';
import 'package:thestyldclubadmin/features/authentication/models/models.dart';
import 'package:thestyldclubadmin/data/repositorys/authentication_repository/authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  // Function save to user data to firestore
  Future<void> createUser(UserModels user) async {
    try {
      return await _db.collection('User').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModels> fecthAdminDetails() async {
    try {
      final docSnapshot =
          await _db
              .collection('User')
              .doc(AuthenticationRepository.instance.authUser!.uid)
              .get();

      return UserModels.fromSnapshot(docSnapshot);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModels> fecthUserDetails(String id) async {
    try {
      final docSnapshot = await _db.collection('User').doc(id).get();

      if (docSnapshot.exists) {
        return UserModels.fromSnapshot(docSnapshot);
      } else {
        return UserModels.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
