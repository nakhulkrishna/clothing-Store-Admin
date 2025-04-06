import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/create_product_controller.dart';

class ProductsTypeWidgets extends StatelessWidget {
  const ProductsTypeWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Text(
                "Products Type",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: TSizes.spaceBtwItems),

              RadioMenuButton(
                value: ProductType.single,
                groupValue: controller.productType.value,
                onChanged: (value) {
                  controller.productType.value = value ?? ProductType.single;
                },
                child: Text('Single'),
              ),
              RadioMenuButton(
                value: ProductType.variable,
                groupValue: controller.productType.value,
                onChanged: (value) {
                  controller.productType.value = value ?? ProductType.single;
                },
                child: Text('Variable'),
              ),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              Text(
                "Products Category",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: TSizes.spaceBtwItems),

              RadioMenuButton(
                value: ItemCategory.man,
                groupValue: controller.itemCategory.value,
                onChanged: (value) {
                  controller.itemCategory.value = value ?? ItemCategory.man;
                },
                child: Text('Men'),
              ),
              RadioMenuButton(
                value: ItemCategory.woman,
                groupValue: controller.itemCategory.value,
                onChanged: (value) {
                  controller.itemCategory.value = value ?? ItemCategory.man;
                },
                child: Text('Women'),
              ),
              RadioMenuButton(
                value: ItemCategory.adornments,
                groupValue: controller.itemCategory.value,
                onChanged: (value) {
                  controller.itemCategory.value = value ?? ItemCategory.man;
                },
                child: Text('adornments'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
