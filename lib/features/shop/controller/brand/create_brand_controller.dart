import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/brands/brands_repositories.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/brand_categories_model.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();
  //* VARIBALES
  RxString imageurl = "".obs;
  final isFeatured = false.obs;
  final loading = false.obs;
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  //* TOGGLE CATEGORY SELECTION
  void toggoleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  //* RESET FIELDS
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageurl.value = "";
    selectedCategories.clear();
  }

  //* PICKING IMAGES
  void pickImage() async {
    final controller = Get.put(MediaController());

    List<ImageModel>? selectedImages =
        await controller.selectedImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      imageurl.value = selectedImage.url;
    }
  }

  //* CREATED NEW BRANDS
  Future<void> createBrand() async {
    try {
      TFullScreenLoader.stopLoading(); // Fixed: Start loader

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!formkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (imageurl.value.isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "Image Missing",
          message: "Please upload a brand image.",
        );
        return;
      }

      final newRecord = Brandmodel(
        productsCount: 0,
        id: "",
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        name: name.text.trim(),
        image: imageurl.value,
      );

      newRecord.id = await BrandsRepositorie.instance.createBrands(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw "Error storing relational data, try again";
        }

        for (var category in selectedCategories) {
          final brandCategory = BrandCategoriesModel(
            brandId: newRecord.id,
            categoryid: category.id,
          );
          await BrandsRepositorie.instance.createBrandCategories(brandCategory);
        }
      }

      newRecord.brandCategories ??= [];
      newRecord.brandCategories!.addAll(selectedCategories);

      BrandController.instance.addItemsToList(newRecord);
      resetFields();

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "New Record has been added",
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      print("Error: $e");
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // Future<void> createBrand() async {
  //   try {
  //     // START LOADING
  //     TFullScreenLoader.stopLoading();

  //     //CEHCKING INTERNET CONNECTIVITY
  //     final isconnected = await NetworkManager.instance.isConnected();
  //     if (!isconnected) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }
  //     //FORM VALIDATION
  //     if (!formkey.currentState!.validate()) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     //MAP DATA
  //     final newRecord = Brandmodel(
  //       productsCount: 0,
  //       id: "",
  //       createdAt: DateTime.now(),
  //       isFeatured: isFeatured.value,
  //       name: name.text.trim(),
  //       image: imageurl.value,
  //     );

  //     newRecord.id = await BrandsRepositorie.instance.createBrands(newRecord);

  //     if (selectedCategories.isNotEmpty) {
  //       if (newRecord.id.isEmpty) {
  //         throw "Wrror storing relational ata , try again";
  //       }

  //       for (var categorys in selectedCategories) {
  //         final brandCategorys = BrandCategoriesModel(
  //           brandId: newRecord.id,
  //           categoryid: categorys.id,
  //         );
  //         await BrandsRepositorie.instance.createBrandCategories(
  //           brandCategorys,
  //         );
  //       }
  //     }
  //     newRecord.brandCategories ??= [];
  //     newRecord.brandCategories!.addAll(selectedCategories);

  //     BrandController.instance.addItemsToList(newRecord);
  //     resetFields();
  //     TFullScreenLoader.stopLoading();

  //     TLoaders.successSnackBar(
  //       title: "Congratulations",
  //       message: "New Record has been added",
  //     );
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
  //   }
  // }
}
