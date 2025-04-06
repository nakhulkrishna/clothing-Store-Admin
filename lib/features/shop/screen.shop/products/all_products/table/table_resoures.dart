import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/produtst_controller.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class TableResoures extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRow[index],
      onTap: () => Get.toNamed(Routes.editProducts, arguments: product),
      onSelectChanged:
          (value) => controller.selectedRow[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
                padding: TSizes.sm,
                width: 50,
                height: 50,
              ),
              SizedBox(width: TSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.title,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        DataCell(Text(controller.getProductStockTotal(product))),

        DataCell(Text(controller.getProductSoldQuantity(product))),
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image:
                    product.brand != null
                        ? product.brand!.image
                        : TImages.defaultImage,
                imageType:
                    product.brand != null ? ImageType.network : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
                padding: TSizes.sm,
                width: 35,
                height: 35,
              ),
              SizedBox(width: TSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.brand != null ? product.brand!.name : "",
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text('\$${controller.getProductPrice(product)}')),
        DataCell(Text(product.formttedDate)),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confrimAndDeleteItem(product),
            onEditPressed:
                () => Get.toNamed(Routes.editProducts, arguments: product),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => controller.filteredItems.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount =>
      controller.selectedRow.where((selected) => selected).length;
}
