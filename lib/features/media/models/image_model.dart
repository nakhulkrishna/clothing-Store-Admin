import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/formatters/formatter.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullpath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;
  final DropzoneFileInterface? dropzoneFile;
  RxBool isSelected = false.obs;
  final Uint8List? localimateToDisplay;

  ImageModel({
    this.mediaCategory = '',
    this.localimateToDisplay,
    this.id = '',
    this.dropzoneFile,
    required this.url,
    required this.folder,
    this.sizeBytes,
    required this.filename,
    this.fullpath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
  });

  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  // Format createdAt and updatedAt
  String get createdAtFormatted => TFormatter.formatDate(createdAt);
  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'mediaCategory': mediaCategory,
      'filename': filename,
      'fullpath': fullpath,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'contentType': contentType,
    };
  }

  // Factory constructor to create ImageModel from Firestore snapshot
  factory ImageModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!; // Get the document data safely

      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'],
        mediaCategory: data['mediaCategory'] ?? '',
        filename: data['filename'] ?? '',
        fullpath: data['fullpath'],
        createdAt:
            data['createdAt'] != null
                ? DateTime.parse(data['createdAt'])
                : null,
        updatedAt:
            data['updatedAt'] != null
                ? DateTime.parse(data['updatedAt'])
                : null,
        contentType: data['contentType'],
      );
    }
    return ImageModel.empty();
  }

  // factory ImageModel.fromfirebaseMetadata(
  //   FullMetadata metdata,
  //   String filename,
  //   String folder,
  //   String donwloadUrl,
  // ) {
  //   return ImageModel(
  //     url: donwloadUrl,
  //     folder: folder,
  //     filename: filename,
  //     contentType: metdata.contentType,
  //     createdAt: metdata.timeCreated,
  //     updatedAt: metdata.updated,
  //     fullpath: metdata.fullPath,
  //     sizeBytes: metdata.size,
  //   );
  // }
    factory ImageModel.fromfirebaseMetadata(
    CustomMetadata metadata,
    String filename,
    String folder,
    String donwloadUrl,
  ) {
    return ImageModel(
      url: donwloadUrl,
      folder: folder,
      filename: filename,
      contentType: metadata.contentType,
      createdAt: metadata.timeCreated,
      updatedAt: metadata.updated,
      fullpath: metadata.fullPath,
      sizeBytes: metadata.size,
    );
  }

  // factory ImageModel.fromfirebaseMetadata(
  //   CustomMetadata metadata, // Use CustomMetadata instead of FullMetadata
  //   String filename,
  //   String folder,
  //   String donwloadUrl,
  // ) {
  //   return ImageModel(
  //     url: donwloadUrl,
  //     folder: folder,
  //     filename: filename,
  //     contentType: metadata.contentType,
  //     createdAt: metadata.timeCreated,
  //     updatedAt: metadata.updated,
  //     fullpath: metadata.fullPath,
  //     sizeBytes: metadata.size,
  //   );
  // }

}

class CustomMetadata {
  final String? contentType;
  final Map<String, String>? customMetadata;
  final String? fullPath;
  final DateTime? timeCreated;
  final DateTime? updated;
  final int? size;

  CustomMetadata({
    this.contentType,
    this.customMetadata,
    this.fullPath,
    this.timeCreated,
    this.updated,
    this.size,
  });
}
