import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/popups/dialogs.dart';
import 'package:thestyldclubadmin/features/media/models/products_attributes_model.dart';

import 'package:thestyldclubadmin/features/shop/controller/products/products_variations_controller.dart';

class ProductsAttributesController extends GetxController {
  static ProductsAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormkey = GlobalKey<FormState>();
  TextEditingController attributes = TextEditingController();
  TextEditingController attributesName = TextEditingController();
  final RxList<ProuctsAttributesModel> productsAttributes =
      <ProuctsAttributesModel>[].obs;

  void addNewAttributes() {
    if (!attributesFormkey.currentState!.validate()) {
      return;
    }
    productsAttributes.add(
      ProuctsAttributesModel(
        name: attributesName.text.trim(),
        values: attributes.text.trim().split('|').toList(),
      ),
    );
    attributesName.text = '';
    attributes.text = "";
  }

  void removeAttributes(int index, BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        Navigator.of(context).pop();
        productsAttributes.removeAt(index);
        ProductsVariationsController.instance.productVartions.value = [];
      },
    );
  }

  void resetProductAttributes() {
    productsAttributes.clear();
  }
}
