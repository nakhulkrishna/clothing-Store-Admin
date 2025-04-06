import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/constants/text_strings.dart';
import 'package:thestyldclubadmin/common/utils/popups/dialogs.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/circular_loader.dart';
import 'package:thestyldclubadmin/data/repositorys/media.repository/media_repository.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/media/screens.media/widgets/media_content.dart';
import 'package:thestyldclubadmin/features/media/screens.media/widgets/media_uploader.dart';
import 'package:universal_html/html.dart' as html;

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneViewController;
  final RxBool loading = false.obs;

  final int initialoadcount = 20;
  final int loadmoreCount = 25;
  final RxBool showImagesUploaderSections = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToupload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductsImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandsImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> alluserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();
  //  get this images functions
  void getMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandsImages.isEmpty) {
        targetList = allBrandsImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductsImages.isEmpty) {
        targetList = allProductsImages;
      } else if (selectedPath.value == MediaCategory.users &&
          alluserImages.isEmpty) {
        targetList = alluserImages;
      }
      final images = await mediaRepository.fecthImagesFromDatabases(
        selectedPath.value,
        initialoadcount,
      );

      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
      TLoaders.errorSnackBar(
        title: "Oh Snap",
        message: 'Unable to fecth images , something went wrong. try again',
      );
    }
  }

  // load more images function
  loadMoreMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandsImages.isEmpty) {
        targetList = allBrandsImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductsImages.isEmpty) {
        targetList = allProductsImages;
      } else if (selectedPath.value == MediaCategory.users &&
          alluserImages.isEmpty) {
        targetList = alluserImages;
      }
      final images = await mediaRepository.loadMoreImagesFromDatabases(
        selectedPath.value,
        initialoadcount,
        targetList.last.createdAt ?? DateTime.now(),
      );

      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
      TLoaders.errorSnackBar(
        title: "Oh Snap",
        message: 'Unable to fecth images , something went wrong. try again',
      );
    }
  }

  Future<void> selectlocalImage() async {
    final files = await dropzoneViewController.pickFiles(
      multiple: true,
      mime: ['image/jpeg', 'image/png'],
    );

    if (files.isNotEmpty) {
      for (var file in files) {
        if (file is html.File) {
          final bytes = await dropzoneViewController.getFileData(file);

          final image = ImageModel(
            url: '',
            folder: '',
            filename: file.type,
            dropzoneFile: file,
            localimateToDisplay: Uint8List.fromList(bytes),
          );
          selectedImagesToupload.add(image);
        }
      }
    }
  }

  void uploadImagesConfirmartion() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
        title: 'Select Folder',
        message: 'Please select the folder in order to upload the images',
      );
      return;
    }

    TDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
          'Are you sure want to upload all the images  in ${selectedPath.value.name.toUpperCase()} folder ?',
    );
  }

  Future<void> uploadImages() async {
    try {
      // Remove cofirmation box
      Get.back();

      // loader
      uploadImagesLoadder();
      MediaCategory selectedCategory = selectedPath.value;

      // get the corresponding list to update

      RxList<ImageModel> targetList;
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandsImages;
          break;

        case MediaCategory.categories:
          targetList = allCategoryImages;

          break;
        case MediaCategory.products:
          targetList = allProductsImages;

          break;
        case MediaCategory.users:
          targetList = alluserImages;

          break;
        default:
          return;
      }

      // upload and add images to target list
      // using a reverse loo to avoid 'error'

      for (int i = selectedImagesToupload.length - 1; i >= 0; i--) {
        var selectedImages = selectedImagesToupload[i];

        final image = selectedImages.dropzoneFile!;
        print("images name type :${image.name}");
        final ImageModel uploadImages = await mediaRepository
            .uploadImagesFileinStorage(
              file: image,
              path: getSelectedPath(),
              imageName: image.name,
            );

        uploadImages.mediaCategory = selectedCategory.name;

        final id = await mediaRepository.uploadImageFileInDatabase(
          uploadImages,
        );

        uploadImages.id = id;

        selectedImagesToupload.removeAt(i);

        targetList.add(uploadImages);
      }
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      // show a warning snack-bar for the error
      TLoaders.warningSnackBar(
        title: 'Error Uploading Image',
        message: 'Something went wrong while uploading your images',
      );
    }
  }

  void uploadImagesLoadder() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text("Uploading images"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    TImages.uploadingImageIllustration,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Text("Sit Tight, Your images are uploading....."),
                ],
              ),
            ),
          ),
    );
  }

  String getSelectedPath() {
    String path = ' ';

    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }

    return path;
  }

  void removeCloudImageConfirmation(ImageModel image) async {
    TDialogs.defaultDialog(
      context: Get.context!,
      content: "Are you sure you want to delete this images",
      onConfirm: () {
        Get.back();

        removeCloudImage(image);
      },
    );
  }

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();
      TFullScreenLoader.stopLoading();
      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: PopScope(
          canPop: false,
          child: SizedBox(width: 150, height: 150, child: TCircularLoader()),
        ),
      );

      await mediaRepository.deleteFileFromStorge(image);
      RxList<ImageModel> targetList;

      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandsImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;

          break;
        case MediaCategory.products:
          targetList = allProductsImages;
          break;

        case MediaCategory.users:
          targetList = alluserImages;
          break;
        default:
          return;
      }

      targetList.remove(image);

      update();
      TLoaders.successSnackBar(
        title: 'Image Deleted',
        message: 'image successfuly deleted from your cloud',
      );
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectedImagesFromMedia({
    List<String>? selectedUrls,
    bool allowSelectioon = true,
    bool multipleSelection = false,
  }) async {
    showImagesUploaderSections.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: TColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              MediaUploader(),
              MediaContent(
                allowSelection: allowSelectioon,
                allowMultipleSelection: multipleSelection,
                alredySelectedUrls: selectedUrls ?? [],
              ),
            ],
          ),
        ),
      ),
    );

    return selectedImages;
  }
}
