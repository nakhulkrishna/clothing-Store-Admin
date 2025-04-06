import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/products_repository/products_repository.dart';
import 'package:thestyldclubadmin/features/media/models/products_category_model.dart';
import 'package:thestyldclubadmin/features/media/models/products_model.dart';

import 'package:thestyldclubadmin/features/shop/controller/products/product_images_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_attributes_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_variations_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/produtst_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;
  final itemCategory = ItemCategory.man.obs;

  final stockPriceFromKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductsRepository());
  final titleDescriptionFromKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<Brandmodel?> selectedBrand = Rx<Brandmodel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  RxBool thumnailUploader = false.obs;
  RxBool additinalImageuploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoryRelationshipUploader = false.obs;
  final attributeController = Get.put(ProductsAttributesController());
  Future<void> createProduct() async {
    try {
      TFullScreenLoader.stopLoading();
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!titleDescriptionFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (productType.value == ProductType.single &&
          !stockPriceFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (selectedBrand.value == null) throw "Select brand For this Products";

      if (productType.value == ProductType.variable &&
          !ProductsVariationsController.instance.productVartions.isEmpty) {
        throw "there areno variations for the products type varibale , create some variations or change products type";
      }

      if (productType.value == ProductType.variable) {
        final variationCheckedFiald = ProductsVariationsController
            .instance
            .productVartions
            .any(
              (e) =>
                  e.price.isNaN ||
                  e.price < 0 ||
                  e.salePrice.isNaN ||
                  e.salePrice < 0 ||
                  e.stock.isNaN ||
                  e.stock < 0 ||
                  e.image.value.isEmpty,
            );

        if (variationCheckedFiald)
          throw "variation data  is not accurate.Please recheck variations";
      }

      thumnailUploader.value = true;
      final imageController = ProductImagesController.instance;

      if (imageController.selectedThumnailImageUrl.value == null)
        throw "Select Product Thumbnail Image";

      additinalImageuploader.value = true;

      final variations = ProductsVariationsController.instance.productVartions;

      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductsVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        prodcutsVariations: variations,
        decription: description.text.trim(),
        productsType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imageController.additinalProductsimagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,

        producstAttributes: attributeController.productsAttributes,

        thumbnail: imageController.selectedThumnailImageUrl.value ?? '',
        date: DateTime.now(),
        itemCategory: ItemCategory.man,
      );

      productDataUploader.value = true;
      newRecord.id = await ProductsRepository.instance.createProduct(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw "Error stroing data. try again";

        categoryRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final productsCategorys = ProductsCategoryModel(
            productId: newRecord.id,
            categoryid: category.id,
          );

          await ProductsRepository.instance.createProductCategory(
            productsCategorys,
          );
        }
      }

      ProductController.instance.addItemsToList(newRecord);
      TFullScreenLoader.stopLoading();
      showCompletingDailog();
      resetValues();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void showProgressDialog() {}

  void showCompletingDailog() {
    Get.dialog(
      AlertDialog(
        title: Text("Congratulations"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text("Go to Products"),
          ),
        ],

        content: Column(
          children: [
            Image.asset(TImages.productsIllustration, height: 200, width: 200),
            SizedBox(height: TSizes.spaceBtwItems),
            Text(
              "Congratulations",
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Text("Your Products has been Created"),
          ],
        ),
      ),
    );
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    itemCategory.value = ItemCategory.man;

    title.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    description.clear();
    brandTextField.clear();

    selectedBrand.value = null;
    selectedCategories.clear();

    thumnailUploader.value = false;
    additinalImageuploader.value = false;
    productDataUploader.value = false;
    categoryRelationshipUploader.value = false;

    // Clear attribute data
    attributeController.productsAttributes.clear();

    // Reset thumbnail & images
    final imageController = ProductImagesController.instance;
    imageController.selectedThumnailImageUrl.value = null;
    imageController.additinalProductsimagesUrls.clear();

    // Reset variations
    final variationController = ProductsVariationsController.instance;
    variationController.resetAllValues();
    variationController.productVartions.clear();
  }
}
