import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/controller/order/order_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/all_orders/table/order_table_soruce.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRow.length.toString());

      return TPaginatedDataTable(
        minWidth: 700,
        sortAscending: controller.sortAssending.value,
        sortColumnIndex: controller.sortColoumnIndex.value,
        columns: [
          DataColumn2(label: Text("Order Id ")),
          DataColumn2(
            label: Text("Date"),
            onSort:
                (columnIndex, ascending) =>
                    controller.sortByDate(columnIndex, ascending),
          ),
          DataColumn2(label: Text("Items")),
          DataColumn2(
            label: Text("Status"),
            fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 : null,
          ),
          DataColumn2(label: Text("Amount")),
          DataColumn2(label: Text("Action"), fixedWidth: 100),
        ],
        source: DataSource(),
      );
    });
  }
}
