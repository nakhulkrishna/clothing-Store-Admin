import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/table/customer_order_rows.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      columns: [
        DataColumn2(label: Text("Order Id")),
        DataColumn2(label: Text("Order Date")),
        DataColumn2(label: Text("Ordered Item")),
        DataColumn2(
          label: Text("Order Status"),
          fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null,
        ),
        DataColumn(label: Text("Amount"), numeric: true),
      ],
      source: CustomerOrderRows(),
    );
  }
}
