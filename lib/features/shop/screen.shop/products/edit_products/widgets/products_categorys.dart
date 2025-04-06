import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/helpers/cloud_helper_functions.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/shimmers/shimmer.dart';
import 'package:thestyldclubadmin/features/media/models/products_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/create_product_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/edit_products_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class ProductsCategorys extends StatelessWidget {
  const ProductsCategorys({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;

    // if (categoriesController.allItems.isEmpty) {
    //   categoriesController.fecthItems();
    // }
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Categories", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),
          FutureBuilder(
            future: productController.loadSelectedCategories(product.id),
            builder: (context, snapshot) {
              final widget = TCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
              );

              if (widget != null) return widget;

              return MultiSelectDialogField(
                title: Text("Categories"),
                buttonText: Text("Select Categories"),
                initialValue: List<CategoryModel>.from(
                  productController.selectedCategories,
                ),
                items:
                    CategorysController.instance.allItems
                        .map(
                          (category) =>
                              MultiSelectItem(category, category.name),
                        )
                        .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (onConfirm) {
                  CreateProductController.instance.selectedCategories.assignAll(
                    onConfirm,
                  );
                },
              );
            },
          ),
          // Obx(
          //   () =>
          //       categoriesController.isLoading.value
          //           ? TShimmerEffect(width: double.infinity, height: 50)
          //           : MultiSelectDialogField(
          //             title: Text("Categories"),
          //             buttonText: Text("Select Categories"),
          //             items:
          //                 categoriesController.allItems
          //                     .map(
          //                       (category) =>
          //                           MultiSelectItem(category, category.name),
          //                     )
          //                     .toList(),
          //             listType: MultiSelectListType.CHIP,
          //             onConfirm: (onConfirm) {
          //               CreateProductController.instance.selectedCategories
          //                   .assignAll(onConfirm);
          //             },
          //           ),
          // ),
        ],
      ),
    );
  }
}
