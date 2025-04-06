import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/produtst_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/all_products/table/table_resoures.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      Visibility(
        visible: false,
        child: Text(controller.filteredItems.length.toString()),
      );
      Visibility(
        visible: false,
        child: Text(controller.selectedRow.length.toString()),
      );

      return TPaginatedDataTable(
        sortAscending: controller.sortAssending.value,
        sortColumnIndex: controller.sortColoumnIndex.value,
        minWidth: 1000,
        columns: [
          DataColumn2(
            onSort:
                (columnIndex, ascending) =>
                    controller.sortbyName(columnIndex, ascending),
            label: Text("Products"),
            fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300 : 400,
          ),

          DataColumn2(
            label: Text("Stock"),
            onSort:
                (columnIndex, ascending) =>
                    controller.sortbyStock(columnIndex, ascending),
          ),
          DataColumn2(
            label: Text("Sold"),
            onSort:
                (columnIndex, ascending) =>
                    controller.sortbySoldItems(columnIndex, ascending),
          ),
          DataColumn2(label: Text("Brand")),
          DataColumn2(
            label: Text("Price"),
            onSort:
                (columnIndex, ascending) =>
                    controller.sortbyPrice(columnIndex, ascending),
          ),
          DataColumn2(label: Text("Date")),
          DataColumn2(label: Text("Action"), fixedWidth: 100),
        ],
        source: TableResoures(),
      );
    });
  }
}
