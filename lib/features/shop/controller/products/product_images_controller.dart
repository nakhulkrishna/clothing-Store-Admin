import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/media/models/products_veriation_model.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  Rx<String?> selectedThumnailImageUrl = Rx<String?>(null);
  final RxList<String> additinalProductsimagesUrls = <String>[].obs;

  void selectedThumbnailImages() async {
    try {
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectedImagesFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;
        selectedThumnailImageUrl.value = selectedImage.url;
      }
    } catch (e) {
      print(e.toString());

      Get.snackbar("Error", "Failed to select thumbnail image: \$e");
    }
  }

  void selectedMultipleProductsImages() async {
    try {
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller
          .selectedImagesFromMedia(
            multipleSelection: true,
            selectedUrls: additinalProductsimagesUrls,
          );
      // final selectedImage = await controller.selectedImagesFromMedia(
      //   multipleSelection: true,
      //   selectedUrls: additinalProductsimagesUrls,
      // );

      if (selectedImages != null && selectedImages.isNotEmpty) {
        additinalProductsimagesUrls.assignAll(selectedImages.map((e) => e.url));
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to select multiple product images: \$e");
    }
  }

  Future<void> removeImage(int index) async {
    additinalProductsimagesUrls.removeAt(index);
  }

  void selectVariationImage(ProductsVeriationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selecteddImages =
        await controller.selectedImagesFromMedia();

    if (selecteddImages != null && selecteddImages.isNotEmpty) {
      ImageModel selectedImage = selecteddImages.first;

      variation.image.value = selectedImage.url;
    }
  }
}
