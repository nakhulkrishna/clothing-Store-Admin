import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thestyldclubadmin/common/utils/popups/dialogs.dart';
import 'package:thestyldclubadmin/features/media/models/products_veriation_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_attributes_controller.dart';

class ProductsVariationsController extends GetxController {
  static ProductsVariationsController get instance => Get.find();

  final isloading = false.obs;

  final RxList<ProductsVeriationModel> productVartions =
      <ProductsVeriationModel>[].obs;

  List<Map<ProductsVeriationModel, TextEditingController>> stockControllerLIst =
      [];
  List<Map<ProductsVeriationModel, TextEditingController>> priceControllerLIst =
      [];
  List<Map<ProductsVeriationModel, TextEditingController>>
  salePriceControllerLIst = [];
  List<Map<ProductsVeriationModel, TextEditingController>>
  descriptionControllerLIst = [];

  final attributesController = Get.put(ProductsAttributesController());

  void initializeVariationController(List<ProductsVeriationModel> variations) {
    stockControllerLIst.clear();
    priceControllerLIst.clear();
    salePriceControllerLIst.clear();
    descriptionControllerLIst.clear();

    for (var variation in variations) {
      // Stock controller
      stockControllerLIst.add({
        variation: TextEditingController(text: variation.stock.toString()),
      });

      // Price controller
      priceControllerLIst.add({
        variation: TextEditingController(text: variation.price.toString()),
      });

      // Sale price controller
      salePriceControllerLIst.add({
        variation: TextEditingController(text: variation.salePrice.toString()),
      });

      // Description controller
      descriptionControllerLIst.add({
        variation: TextEditingController(text: variation.description ?? ''),
      });
    }
  }

  void removeVariations(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      title: "Remove variations",
      onConfirm: () {
        productVartions.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      cancelText: "Generate",
      title: 'Generate Variations',
      content:
          "once the variations are created, you cant add more attributes. in order to add more variations, you have to delete any of the attributes",
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  void generateVariationsFromAttributes() {
    Get.back();

    final List<ProductsVeriationModel> variations = [];

    if (attributesController.productsAttributes.isNotEmpty) {
      final List<List<String>> attributesCombinations = getCombinations(
        attributesController.productsAttributes
            .map((attr) => attr.values ?? <String>[])
            .toList(),
      );

      for (var combination in attributesCombinations) {
        final Map<String, String> attributesValues = Map.fromIterables(
          attributesController.productsAttributes.map(
            (attr) => attr.name ?? "",
          ),
          combination,
        );
        final ProductsVeriationModel variation = ProductsVeriationModel(
          id: UniqueKey().toString(),
          attributesValues: attributesValues,
        );

        variations.add(variation);

        Map<ProductsVeriationModel, TextEditingController> stockController = {};
        Map<ProductsVeriationModel, TextEditingController> priceController = {};
        Map<ProductsVeriationModel, TextEditingController> salePriceController =
            {};
        Map<ProductsVeriationModel, TextEditingController>
        descriptionController = {};

        stockController[variation] = TextEditingController();
        priceController[variation] = TextEditingController();

        salePriceController[variation] = TextEditingController();

        descriptionController[variation] = TextEditingController();

        stockControllerLIst.add(stockController);
        priceControllerLIst.add(stockController);

        salePriceControllerLIst.add(stockController);

        descriptionControllerLIst.add(stockController);
      }
    }
    productVartions.assignAll(variations);
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];
    combine(lists, 0, <String>[], result);

    return result;
  }

  void combine(
    List<List<String>> lists,
    int index,
    List<String> current,
    List<List<String>> result,
  ) {
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }
    for (final item in lists[index]) {
      final List<String> updated = List.from(current)..add(item);
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    productVartions.clear();
    stockControllerLIst.clear();
    priceControllerLIst.clear();
    descriptionControllerLIst.clear();
    salePriceControllerLIst.clear();
  }
}
