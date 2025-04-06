import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/table/brands_rows.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());

    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRow.length.toString());
      final lgTable = controller.filteredItems.any(
        (element) =>
            element.brandCategories != null &&
            element.brandCategories!.length > 2,
      );
      return TPaginatedDataTable(
        columns: [
          DataColumn2(
            label: Text("Brand"),
            fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200,

            onSort:(columnIndex, ascending) => controller.sortByName(columnIndex, ascending, ),
          ),

          DataColumn2(label: Text("Categories")),
          DataColumn2(
            label: Text("featured"),
            fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100,
          ),
          DataColumn2(
            label: Text("Date"),
            fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
          ),
          DataColumn2(
            label: Text("Action"),
            fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100,
          ),
        ],
        sortAscending: controller.sortAssending.value,
        sortColumnIndex: controller.sortColoumnIndex.value,
        tableHeight: lgTable ? 96 * 11.5 : 760,
        dataRowHeight: lgTable ? 96 : 64,
        source: BrandsRows(),
        minWidth: 700,
      );
    });
  }
}
