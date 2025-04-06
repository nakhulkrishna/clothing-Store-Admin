import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/banner_repositorys/banner_repositories.dart';
import 'package:thestyldclubadmin/data/repositorys/brands/brands_repositories.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';
import 'package:thestyldclubadmin/features/shop/models/brand_categories_model.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();
  //* VARIBALES
  RxString imageurl = "".obs;
  final isFeatured = false.obs;
  final loading = false.obs;
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final repositorys = Get.put(BrandsRepositorie());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  void init(Brandmodel brand) {
    name.text = brand.name;
    imageurl.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

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

  // Update  BRANDS
  Future<void> updateBrands(Brandmodel brand) async {
    try {
      // START LOADING
      TFullScreenLoader.stopLoading();

      //CEHCKING INTERNET CONNECTIVITY
      final isconnected = await NetworkManager.instance.isConnected();
      if (!isconnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //FORM VALIDATION
      if (!formkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      bool isBrandsUpdated = false;

      if (brand.image != imageurl.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        brand.image = imageurl.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        await repositorys.updateBrands(brand);
      }

      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

    
      BrandController.instance.updateItemsFromList(brand);

      update();

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

  updateBrandCategories(Brandmodel brand) async {
    final brandCategories = await repositorys.getCategoriesOfSpecificbrand(
      brand.id,
    );

    final selectedcategoriesid = selectedCategories.map((e) => e.id);

    final categgoryToRemove =
        brandCategories
            .where(
              (existingCatgories) =>
                  !selectedcategoriesid.contains(existingCatgories.categoryid),
            )
            .toList();

    for (var categgorytoRemove in categgoryToRemove) {
      await BrandsRepositorie.instance.deleteBrandsCategories(
        categgorytoRemove.id ?? "",
      );
    }

    final newCategoriesToAdd =
        selectedCategories
            .where(
              (newCategories) =>
                  !brandCategories.any(
                    (exsitingCategpries) =>
                        exsitingCategpries.categoryid == newCategories.id,
                  ),
            )
            .toList();

    for (var newCategory in newCategoriesToAdd) {
      var brandCategories = BrandCategoriesModel(
        brandId: brand.id,
        categoryid: newCategory.id,
      );

      brandCategories.id = await BrandsRepositorie.instance
          .createBrandCategories(brandCategories);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemsFromList(brand);
  }
}
