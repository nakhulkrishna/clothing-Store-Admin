import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/helpers/network_manager.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/repositorys/products_repository/products_repository.dart';

import 'package:thestyldclubadmin/features/media/models/products_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/product_images_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_attributes_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_variations_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final titleDescriptionFromKey = GlobalKey<FormState>();
  final stockPriceFromKey = GlobalKey<FormState>();
  final productVisibility = ProductVisibility.hidden.obs;
  final itemCategory = ItemCategory.man.obs;

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<Brandmodel?> selectedBrand = Rx<Brandmodel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alredySelectedCategories = <CategoryModel>[];

  final attributeController = Get.put(ProductsAttributesController());
  final variationController = Get.put(ProductsVariationsController());
  final imageController = Get.put(ProductImagesController());
  final productRepository = Get.put(ProductsRepository());

  RxBool thumbnailUploader = true.obs;
  RxBool productDataUploader = false.obs;
  RxBool additionalImagesUploader = true.obs;
  RxBool categoriesRelationShipUploader = false.obs;
  void initProductsData(ProductModel product) {
    try {
      isLoading.value = true;
      title.text = product.title;
      description.text = product.decription ?? "";
      productType.value =
          product.productsType == ProductType.single.toString()
              ? ProductType.single
              : ProductType.variable;

      if (product.productsType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? "";

      if (product.images != null) {
        imageController.selectedThumnailImageUrl.value = product.thumbnail;

        imageController.additinalProductsimagesUrls.assignAll(
          product.images ?? [],
        );
      }

      attributeController.productsAttributes.assignAll(
        product.producstAttributes ?? [],
      );
      variationController.productVartions.assignAll(
        product.prodcutsVariations ?? [],
      );

      variationController.initializeVariationController(
        product.prodcutsVariations ?? [],
      );

      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;

    final productsCategories = await productRepository.getProductsCategories(
      productId,
    );

    final categoriesController = Get.put(CategorysController());

    final categoriesIds = productsCategories.map((e) => e.categoryid).toList();

    final categories =
        categoriesController.allItems
            .where((element) => categoriesIds.contains(element.id))
            .toList();

    selectedCategories.assignAll(categories);
    alredySelectedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  Future<void> updateProduct() async {
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

      if (!stockPriceFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (selectedBrand.value == null) throw "Select brand for this product.";

      // final updatedProduct = product.copyWith(
      //   title: title.text.trim(),
      //   stock: int.tryParse(stock.text.trim()) ?? 0,
      //   price: double.tryParse(price.text.trim()) ?? 0,
      //   salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
      //   decription: description.text.trim(),
      //   brand: selectedBrand.value,
      //   images: imageController.additinalProductsimagesUrls,
      //   thumbnail: imageController.selectedThumnailImageUrl.value ?? '',
      //   producstAttributes: attributeController.productsAttributes,
      //   prodcutsVariations: variationController.productVartions,
      //   date: DateTime.now(),
      // );

      // await productRepository.updateProduct(updatedProduct);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Success",
        message: "Product updated successfully.",
      );
      Get.back();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
