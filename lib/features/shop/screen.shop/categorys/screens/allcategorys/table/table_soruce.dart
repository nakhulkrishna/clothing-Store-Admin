import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class CategoryRows extends DataTableSource {
  //* INSTANCES
  final controller = CategorysController.instance;

  @override
  DataRow? getRow(int index) {
    final categorires = controller.filteredItems[index];
    final paremtCategories = controller.allItems.firstWhereOrNull(
      (item) => item.id == categorires.parentId,
    );

    return DataRow2(
      selected: controller.selectedRow[index],
      onSelectChanged:
          (value) => controller.selectedRow[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: categorires.image,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
                padding: TSizes.sm,
                width: 50,
                height: 50,
              ),
              SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  categorires.name,
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

        DataCell(Text(paremtCategories != null ? paremtCategories.name : "")),
        DataCell(
          categorires.isFeatured
              ? Icon(Iconsax.heart5, color: TColors.primary)
              : Icon(Iconsax.heart),
        ),
        DataCell(
          Text(categorires.createdAt == null ? "" : categorires.formattedDate),
        ),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confrimAndDeleteItem(categorires),
            onEditPressed:
                () =>
                    Get.toNamed(Routes.editCategories, arguments: categorires),
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
  int get selectedRowCount => 0;
}
