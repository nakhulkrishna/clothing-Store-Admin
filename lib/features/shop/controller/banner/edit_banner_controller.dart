import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/banner_repositorys/banner_repositories.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageurl = "".obs;
  final loading = false.obs;
  final isActive = false.obs;
  final targetScreen = "".obs;
  final formkey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepositories());

  void init(BannerModel banner) {
    imageurl.value = banner.image;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  void pickImage() async {
    final controller = Get.put(MediaController());

    List<ImageModel>? selectedImages =
        await controller.selectedImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      imageurl.value = selectedImage.url;
    }
  }

  Future<void> EditBannerControllerBanner(BannerModel banner) async {
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

      if (banner.image != imageurl.value ||
          banner.targetScreen != targetScreen.value ||
          banner.active != isActive.value) {
        banner.image = imageurl.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        await repository.updateBanner(banner);
      }

      BannerController.instance.updateItemsFromList(banner);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "New Record has been added",
      );
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
      TFullScreenLoader.stopLoading();
    } finally {
      TFullScreenLoader.stopLoading(); // 🟥 Always stop loading
    }
  }
}
