import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/brand_controller.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class BrandsRows extends DataTableSource {
  final controller = BrandController.instance;

  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRow[index],
      onSelectChanged:
          (value) => controller.selectedRow[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
                image: brand.image,
                width: 50,
                height: 50,
                padding: TSizes.sm,
              ),

              Expanded(
                child: Text(
                  brand.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                ),
              ),
            ],
          ),
        ),

        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(vertical: TSizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child: Wrap(
                spacing: TSizes.xs,

                direction:
                    TDeviceUtils.isMobileScreen(Get.context!)
                        ? Axis.vertical
                        : Axis.horizontal,

                children:
                    brand.brandCategories != null
                        ? brand.brandCategories!
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      TDeviceUtils.isMobileScreen(Get.context!)
                                          ? 0
                                          : TSizes.xs,
                                ),
                                child: Chip(
                                  label: Text(e.name),
                                  padding: EdgeInsets.all(TSizes.xs),
                                ),
                              ),
                            )
                            .toList()
                        : [SizedBox()],
              ),
            ),
          ),
        ),

        DataCell(
          brand.isFeatured
              ? Icon(Iconsax.heart)
              : Icon(Iconsax.heart5, color: TColors.primary),
        ),
        DataCell(Text(brand.createdAt != null ? brand.formattedDate : "")),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confrimAndDeleteItem(brand),
            onEditPressed:
                () => Get.toNamed(Routes.editBrands, arguments: brand),
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
