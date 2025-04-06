import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/categorys/category_repositories.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class EditCategoriesController extends GetxController {
  static EditCategoriesController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;

  final loading = false.obs;

  RxString imageUrl = "".obs;

  final isFeatured = false.obs;

  final name = TextEditingController();

  final formKey = GlobalKey<FormState>();
  void init(CategoryModel model) {
    name.text = model.name;
    isFeatured.value = model.isFeatured;
    imageUrl.value = model.image;
    if (model.parentId.isNotEmpty) {
      selectedParent.value =
          CategorysController.instance.allItems
              .where((c) => c.id == model.parentId)
              .single;
    }
  }

  Future<void> updatedCategorys(CategoryModel model) async {
    try {
      TFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "Please check your connection.",
        );

        return;
      }

      print("conntecion checked");

      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      model.image = imageUrl.value;
      model.name = name.text.trim();
      model.parentId = selectedParent.value.id;
      model.isFeatured = isFeatured.value;
      model.updatedAt = DateTime.now();
      await CategoryRepositories.instance.updateCategories(model);
      CategorysController.instance.updateItemsFromList(model);
      resetFields();

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "New record has been added",
      );
    } catch (e, s) {
      TFullScreenLoader.stopLoading();
      // log(e.toString(), stackTrace: s);
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  //* IMAGES PICKING FOR CATEGORIES
  void pickImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await controller.selectedImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedimage = selectedImages.first;
      imageUrl.value = selectedimage.url;
    }
  }

  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageUrl.value = '';
  }
}
