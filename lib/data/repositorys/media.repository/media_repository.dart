import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:universal_html/html.dart' as html;
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

/// Media Repository to handle image uploads and database operations
class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Cloudinary Configuration
  final String cloudinaryApiKey = '152827531353165';
  final String cloudinaryApiSecret = 'ZixCKxldsmGlXOdx31ErgFqXX-0';
  final String cloudinaryCloudName = 'dpxel4aym';
  String cloudinaryUrl =
      "cloudinary://152827531353165:ZixCKxldsmGlXOdx31ErgFqXX@dpxel4aym";

  /// Upload Image File to Cloudinary and return ImageModel
  Future<ImageModel> uploadImagesFileinStorage({
    required DropzoneFileInterface file,
    required String path,
    required String imageName,
  }) async {
    try {
      final nativeFile = file.getNative();

      if (nativeFile is! html.Blob) {
        throw 'Unsupported file type: ${nativeFile.runtimeType}';
      }

      // Read file as byte array
      final reader = html.FileReader();
      reader.readAsArrayBuffer(nativeFile);
      await reader.onLoad.first;

      final Uint8List byteData = reader.result as Uint8List;
      final String base64Image = base64Encode(byteData);

      // Cloudinary Upload API Endpoint
      final String uploadUrl =
          'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/upload';

      final Map<String, String> body = {
        'file': 'data:image/png;base64,$base64Image',
        'upload_preset': 'ml_default',
        'public_id': '$path/$imageName',
      };

      final response = await http.post(Uri.parse(uploadUrl), body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String downloadURL = data['secure_url'];

        // Metadata extraction
        final CustomMetadata metadata = CustomMetadata(
          contentType: data['format'] ?? 'unknown',
          fullPath: data['public_id'] ?? 'unknown',
          timeCreated: DateTime.tryParse(data['created_at'] ?? ""),
          updated: DateTime.tryParse(data['updated_at'] ?? ""),
          size: data['bytes'] ?? 0,
        );
        print(data);
        return ImageModel.fromfirebaseMetadata(
          metadata,
          path,
          imageName,
          downloadURL,
        );
      } else {
        throw 'Failed to upload image to Cloudinary';
      }
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

  /// Upload Image Metadata to Firestore and return Document ID
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      print('Uploading image to Firestore: ${image.toJson()}');
      final data = await FirebaseFirestore.instance
          .collection('images')
          .add(image.toJson());
      print('Upload successful, document ID: ${data.id}');
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

  // Fecth images from data bases  cloudnary and firebases
  Future<List<ImageModel>> fecthImagesFromDatabases(
    MediaCategory mediacategorys,
    int loadCount,
  ) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('images')
              .where('mediaCategory', isEqualTo: mediacategorys.name.toString())
              .orderBy('createdAt', descending: true)
              .limit(loadCount)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
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

  Future<List<ImageModel>> loadMoreImagesFromDatabases(
    MediaCategory mediacategorys,
    int loadCount,
    DateTime lastfechedTime,
  ) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('images')
              .where('mediaCategory', isEqualTo: mediacategorys.name.toString())
              .orderBy('createdAt', descending: true)
              .startAfter([lastfechedTime])
              .limit(loadCount)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
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

  Future<void> deleteFileFromStorge(ImageModel image) async {
    try {
      final ref = FirebaseStorage.instance.ref(
        "Categories/Screenshot 2025-01-12 163338.png",
      );

      // Try fetching the download URL to confirm the file exists
      await ref.getDownloadURL();
      // // 1️⃣ Delete from Firebase Storage
      // print("Deleting..... from  firebase. :${image.sizeBytes}");
      // await FirebaseStorage.instance.ref('image').delete();

      // print("Delete from  firebase.");
      // // 2️⃣ Cloudinary API Endpoint
      final String deleteUrl =
          'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/destroy';

      // 3️⃣ Request Body
      final Map<String, String> body = {
        'public_id': image.fullpath!,
        'resource_type': 'image',
      };

      // 4️⃣ Basic Authentication for Cloudinary
      final String basicAuth =
          'Basic ' +
          base64Encode(utf8.encode('$cloudinaryApiKey:$cloudinaryApiSecret'));

      // 5️⃣ Send HTTP Request
      final response = await http.post(
        Uri.parse(deleteUrl),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        log('Image deleted successfully: ${image.fullpath}');
      } else {
        throw 'Failed to delete image from Cloudinary: ${response.body}';
      }
      // try {
      //   print("Delete function called.");
      //   await FirebaseStorage.instance.ref(image.fullpath).delete();
      //    final String deleteUrl =
      //       'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/destroy';

      //   final Map<String, String> body = {
      //     'public_id': image.fullpath!,
      //     'resource_type': 'image',
      //   };
      //   print("body for delete data :$body");

      //   final String basicAuth =
      //       'Basic ' +
      //       base64Encode(utf8.encode('$cloudinaryApiKey:$cloudinaryApiSecret'));
      //   final response = await http.post(
      //     Uri.parse(deleteUrl),
      //     headers: {
      //       'Authorization': basicAuth,
      //       'Content-Type': 'application/x-www-form-urlencoded',
      //     },
      //     body: body,
      //   );

      //   print('deleted imagesss..');

      //   if (response.statusCode == 200) {
      //     log('Image deleted successfully: ${image.fullpath}');
      //   } else {
      //     print(response.statusCode);
      //     throw 'Failed to delete image from Cloudinary: ${response.body}';
      //   }
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
