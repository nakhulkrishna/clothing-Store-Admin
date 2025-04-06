import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/banner_repositorys/banner_repositories.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final imageurl = "".obs;
  final loading = false.obs;
  final isActive = false.obs;
  final formkey = GlobalKey<FormState>();

  void pickImage() async {
    final controller = Get.put(MediaController());

    List<ImageModel>? selectedImages =
        await controller.selectedImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      imageurl.value = selectedImage.url;
    }
  }

  Future<void> createBanner() async {
    try {
      TFullScreenLoader.stopLoading();

      final isconnected = await NetworkManager.instance.isConnected();

      if (!isconnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!formkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final newRecord = BannerModel(
        id: "",
        image: imageurl.value,
        targetScreen: 'targetScreen',
        active: isActive.value,
      );

      newRecord.id = await BannerRepositories.instance.createBanner(newRecord);

      BannerController.instance.addItemsToList(newRecord);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "New Record has been added",
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
