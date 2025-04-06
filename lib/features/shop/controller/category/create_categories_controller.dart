
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/categorys/category_repositories.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class CreateCategoriesController extends GetxController {
  static CreateCategoriesController get instance => Get.find();

  //* VARIBALES
  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageUrl = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //* CRATE NEW CATEGORIES
  Future<void> createcategories() async {
    try {
      TFullScreenLoader.popUpCircular();
      print("loading acceseed");
      final isConnected = await NetworkManager.instance.isConnected();
      print("connection initilazed");
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

      print("form validated");
      final newRecord = CategoryModel(
        name: name.text.trim(),
        id: "",
        image: imageUrl.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        // parentId: "1243",
        parentId: selectedParent.value.id,
      );
      print("newRecord");
      newRecord.id = await CategoryRepositories.instance.createCategories(
        newRecord,
      );
      CategorysController.instance.addItemsToList(newRecord);
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
