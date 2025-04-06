import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class BannerRows extends DataTableSource {
  final controller = BannerController.instance;

  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRow[index],
      onSelectChanged:
          (value) => controller.selectedRow[index] = value ?? false,
      onTap: () => Get.toNamed(Routes.editBanner, arguments: banner),
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
                image: banner.image,
                width: 180,
                height: 100,
                padding: TSizes.sm,
              ),
            ],
          ),
        ),

        DataCell(Text(controller.formatRoute(banner.targetScreen))),
        DataCell(
          banner.active
              ? Icon(Iconsax.eye, color: TColors.primary)
              : Icon(Iconsax.eye_slash),
        ),
        DataCell(
          TTableActionButtons(
            onDeletePressed: () => controller.confrimAndDeleteItem(banner),
            onEditPressed:
                () => Get.toNamed(Routes.editBanner, arguments: banner),
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
  int get selectedRowCount => controller.selectedRow.where((e) => e).length;
}
