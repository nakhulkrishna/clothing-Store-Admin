import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:thestyldclubadmin/features/shop/controller/dashboard/dashboard_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/order/order_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class DataSource extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    return DataRow2(
      onTap:
          () => Get.toNamed(
            Routes.orderDetails,
            arguments: order,
            parameters: {'orderId': order.id},
          ),
      selected: controller.selectedRow[index],
      onSelectChanged:
          (value) => controller.selectedRow[index] = value ?? false,

      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.primary),
          ),
        ),

        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text("${order.item.length} Items")),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: EdgeInsets.symmetric(
              vertical: TSizes.sm,
              horizontal: TSizes.md,
            ),
            backgroundColor: THelperFunctions.getOrderStatusColor(
              order.status,
            ).withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.status),
              ),
            ),
          ),
        ),
        DataCell(Text("\$${order.totalAmount}")),

        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed:
                () => Get.toNamed(
                  Routes.orderDetails,
                  arguments: order,
                  parameters: {'orderId': order.id},
                ),
            onDeletePressed: () {},
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
